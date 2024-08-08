import os
import numpy as np
import pandas as pd
import glob


def feature_compliation():
    dir = os.getcwd() + "/BRAVEHEART-main/Example ECGs/12-lead-mat/features/"

    csv_files = glob.glob(os.path.join(dir, '*.csv'))

    # Initialize an empty DataFrame to hold all the data
    all_data_df = pd.DataFrame()

    # Loop through the list of csv files
    for csv_file in csv_files:
        # Load the current CSV file into a DataFrame
        temp_df = pd.read_csv(csv_file)

        # if temp_df.isna().any().any():
        #     print(csv_file)
        
        # Append the contents of the current DataFrame to the main DataFrame
        all_data_df = pd.concat([all_data_df, temp_df], ignore_index=True)

    all_data_df.to_csv(os.getcwd() + '/data/public_dataset.csv', index=False)

    print('Compliation completed')