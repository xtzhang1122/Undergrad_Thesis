function [result] = qrs_notching_slurring_check(data)

    lead_names = {'I', 'V1', 'V2', 'V5', 'V6', 'avL'};
    figure;
    
    for j = 1: length(lead_names)
        
        if lead_names{j} == 'I'
            q_loc = strcat('L1', '_q_loc');
            s_loc = strcat('L1', '_s_loc');
        else
            q_loc = strcat(lead_names{j}, '_q_loc');
            s_loc = strcat(lead_names{j}, '_s_loc');
        end

        % QRS after 40 ms
        y = data.median_12L.(lead_names{j})(data.lead_morph.(q_loc) + 25: data.lead_morph.(s_loc));
    
        % % first derivative
        % slopes = diff(y);
        % 
        % % Compute the second derivative to find curvature changes
        % curvature = diff(slopes);
        % 
        % % Initialize indices array
        % featureIndices = [];
        % 
        % % Detect zero-crossings in the second derivative for notching
        % zeroCrossings = find(diff(sign(curvature)));
        % 
        % curvatureThreshold = 1;
        % for i = 1:length(zeroCrossings)
        %     notchIndex = zeroCrossings(i) + 1; % +1 to account for the diff offset
        %     % Check for a sign change in curvature which indicates a notch
        %     % And check if the change in curvature exceeds the threshold
        %     if sign(curvature(notchIndex-1)) ~= sign(curvature(notchIndex)) && ...
        %        abs(curvature(notchIndex-1)) > curvatureThreshold && ...
        %        abs(curvature(notchIndex)) > curvatureThreshold
        %         featureIndices = unique([featureIndices, notchIndex]);
        %     end
        % end
        % 
        % 
        % % Detect slurring using a run of consecutive positive or negative slopes
        % slurringThreshold = 7; % Define how many consecutive points you need for slurring
        % 
        % 
        % i = 1;
        % while i <= length(slopes) - slurringThreshold + 1
        %     if (all(slopes(i:i+slurringThreshold-1) > 0.05) || all(slopes(i:i+slurringThreshold-1) < -0.05))
        %         % Add only the middle index of the slurring event
        %         middleIndex = i + floor(slurringThreshold / 2);
        %         featureIndices = [featureIndices, middleIndex];
        %         % Skip to the end of this slurring event to avoid adjacent points
        %         i = i + slurringThreshold;
        %     else
        %         i = i + 1;
        %     end
        % end
        % 
        % 
        % % Remove duplicate indices and sort them
        % featureIndices = unique(featureIndices);
        % 
        % % Count the number of unique features
        % FeatureCount = length(featureIndices);
        % 
        % visualization
        
        plot(y);
        hold on;
        % plot(featureIndices, y(featureIndices), 'ro');
        % hold on;
        
        
        
        % % final check
        % if FeatureCount >= 2
        %     disp(lead_names{j})
        %     result = true;
        %     break;
        % end
        % 
        % result = false;

        

    end

    legend(lead_names);
    hold off;

    result = input('Pasued for Irregular QRS [enter 0 or 1]:  ');
    
end