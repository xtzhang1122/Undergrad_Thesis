function value = median_or_warn(variable_name, value)
    % Check if the input is a cell array
    if iscell(value)
        % disp('is cell array')
        % Process each cell in the array individually
        for i = 1:numel(value)
            if numel(value{i}) ~= 1
                fprintf('Non-singleton found in %s at index %d: %s\n', variable_name, i, mat2str(value{i}));
                value{i} = round(median(value{i}));
            end
        end
    else
        % If the input is not a cell array, check and process it directly
        % disp('is not cell array')
        % disp(numel(value))
        if numel(value) ~= 1
            fprintf('Non-singleton found in %s: %s\n', variable_name, mat2str(value));
            value = round(median(value));
       
        end
    end
end
