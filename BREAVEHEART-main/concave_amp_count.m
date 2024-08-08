function [count] = concave_amp_count(index_list, sig_list)

count = 0;
% Iterate through each pair of consecutive wave indices
for i = 1: length(index_list)
    sig = sig_list{i};
    indices = index_list{i};

    for j = 1: length(indices)
        wave = indices(j);
        
        % Extract the sub-signal corresponding to the current wave
        wave_range = sig(max(1, wave-50): min(wave+50, length(wave)));
        
        % Check if the wave is concave
        if all(diff(diff(wave_range)) < 0)
            count = count + 1;
        end

    end
end

end