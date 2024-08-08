import os
import wfdb
from scipy.io import savemat
from multiprocessing import Pool, freeze_support

# Function to process a single directory
def process_folder(directory, base_dir, result_base_dir):
    # Create result directory
    result_dir = os.path.join(result_base_dir)
    os.makedirs(result_dir, exist_ok=True)

    # Path to the directory containing records
    records_dir = os.path.join(base_dir, directory.replace('/', os.sep))  # Normalize path separator
    records_path = os.path.join(records_dir, 'RECORDS')

    # If RECORDS file exists, process the files listed
    if os.path.exists(records_path):
        # Read the list of file identifiers from the RECORDS file
        with open(records_path, 'r') as records_file:
            data_args_list = []
            for line in records_file:
                file_id = line.strip()
                mat_path = os.path.join(base_dir, directory, file_id + '.mat').replace('/', os.sep)
                hea_path = os.path.join(base_dir, directory, file_id).replace('/', os.sep)

                # If .mat file exists, add to data arguments list
                if os.path.exists(mat_path):
                    data_args_list.append((mat_path, hea_path, result_dir, file_id))

            # Process files using multiprocessing
            with Pool() as pool:
                pool.map(process_file_data, data_args_list)

    # Recursively process subdirectories
    for sub_dir in os.listdir(records_dir):
        sub_dir_path = os.path.join(records_dir, sub_dir)
        if os.path.isdir(sub_dir_path):
            process_folder(sub_dir, base_dir, result_base_dir)


def process_file_data(data_args):
    mat_path, hea_path, result_dir, file_id = data_args
    output_mat_dic = {}

    # Read the WFDB file using rdsamp function
    signals, meta = wfdb.rdsamp(hea_path)

    # Access metadata information
    sample_rate = meta['fs']
    signal_length = meta['sig_len']
    num_signals = meta['n_sig']
    signal_names = meta['sig_name']

    age = meta['comments'][0][5:]
    sex = meta['comments'][1][5:]
    sex = 'M' if sex == 'Male' else 'F'

    mi_list = meta['comments'][2][5:].split(',')
    mi_list = [eval(i) for i in mi_list]
    mi = 1 if 164865005 in mi_list else 0

    # Adding these information to output
    output_mat_dic = {
        'sample_rate': sample_rate,
        'signal_length': signal_length,
        'num_signals': num_signals,
        'signal_names': signal_names,
        'age': age,
        'sex': sex,
        'mi': mi
    }

    # For the loop, assuming the shape of `signals` is (signal_length, num_signals)
    for ind in range(num_signals):
        # Directly store the signal; if more complex manipulation is needed, adjust accordingly
        output_mat_dic[signal_names[ind]] = signals[:, ind].tolist()

    # Save to .mat file
    mat_path = os.path.join(result_dir, f"{file_id}.mat")
    savemat(mat_path, output_mat_dic)


    
# Main block
if __name__ == '__main__':
    freeze_support()
    # Define records directory
    records_directory = os.getcwd() + '/a-large-scale-12-lead-electrocardiogram-database-for-arrhythmia-study-1.0.0'
    
    # Read subfolder paths from the RECORDS file
    with open(os.path.join(records_directory, 'RECORDS'), 'r') as first_records_file:
        subfolder_paths = first_records_file.read().splitlines()
    
    # Iterate through subfolder paths and process each folder
    for index, subfolder_path in enumerate(subfolder_paths):
        process_folder(subfolder_path, records_directory, '12-lead-mat')
        print(index + 1)  # Print index to track progress