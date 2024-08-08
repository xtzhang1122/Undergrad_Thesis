function [lead_i, lead_ii, avf, avl, v1, v2, v3, v4, v5, v6] = amplitude_adjustment(data, age, gender)

age_diff = age - 55;

lead_i = data.median_12L.I;
lead_ii = data.median_12L.II;
avf = data.median_12L.avF;
avl = data.median_12L.avL;
v1 = data.median_12L.V1;
v2 = data.median_12L.V2;
v3 = data.median_12L.V3;
v4 = data.median_12L.V4;
v5 = data.median_12L.V5;
v6 = data.median_12L.V6;

leads = [lead_i, lead_ii, avf, avl, v1, v2, v3, v4, v5, v6];

% Adjusting each value in the array
for i = 1:length(leads)
    leads(i) = leads(i) - 0.01 * age_diff;

    % Adjust duration for females
    if gender == 'F'
        leads(i) = resample(leads(i), data.median_12L.hz * 0.9, data.median_12L.hz);
    end
end

lead_i = leads(:, 1);
lead_ii = leads(:, 2);
avf = leads(:, 3);
avl = leads(:, 4);
v1 = leads(:, 5);
v2 = leads(:, 6);
v3 = leads(:, 7);
v4 = leads(:, 8);
v5 = leads(:, 9);
v6 = leads(:, 10);

end