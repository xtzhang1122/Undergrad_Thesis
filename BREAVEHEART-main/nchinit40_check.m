function [score] = nchinit40_check(signal)

    score = 0;
    
    Fs = 500; 
    if Fs ~= 500
        disp('frequency is %d', Fs)
    end

    timeWindow = 0.040; % 40 ms
    numSamples = floor(Fs * timeWindow);
    
    % Analyze the signal within the first 40 ms
    for i = 2:numSamples-1
        % Calculate the slope angle for each segment
        angle1 = atan2(signal(i) - signal(i-1), 1); % Angle with previous point
        angle2 = atan2(signal(i+1) - signal(i), 1); % Angle with next point
    
        % Convert angles to degrees
        angle1 = rad2deg(angle1);
        angle2 = rad2deg(angle2);
    
        % Check for a change in direction of at least 90 degrees
        if abs(angle1 - angle2) >= 90
            disp(['Notch detected starting at sample ' num2str(i)]);
            score = 1;
        end

    end

    
end