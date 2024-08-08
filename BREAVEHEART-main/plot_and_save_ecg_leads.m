function plot_and_save_ecg_leads(data, directory)
    % Check if the directory exists, if not, create it
    if ~exist(directory, 'dir')
        mkdir(directory);
    end
    
    % Extract ECG leads from the data structure
    leads = {'I', 'II', 'III', 'avF', 'avL', 'avR', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
    
    % Extract sampling frequency and units (assuming these fields exist)
    Fs = data.median_12L.hz;
    units = data.median_12L.units;
    
    % Predefine the figure for efficiency
    fig = figure('visible', 'off');
    
    % Loop over each lead
    for i = 1:length(leads)
        % Extract the lead data using dynamic field names
        lead_data = data.median_12L.(leads{i});
        
        % Plot the lead
        plot((1:length(lead_data))/Fs, lead_data);
        title(['Lead ', leads{i}]);
        xlabel(['Time (', units, ')']);
        ylabel('Amplitude (mV)'); % Adjust the units if necessary
        
        % Save the plot to the directory
        saveas(fig, fullfile(directory, ['ECG_Lead_' leads{i} '.png']));
    end
    
    % Close the figure
    close(fig);
end
