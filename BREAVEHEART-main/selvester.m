function [MIsz] = selvester(data, age, gender)

    % replace original signal in data with the adjusted one
    [lead_i, lead_ii, avf, avl, v1, v2, v3, v4, v5, v6] = amplitude_adjustment(data, age, gender);

    qrs_data = data;
    qrs_scoring_ecg = ECG12(data.median_12L.hz, data.median_12L.units, lead_i, lead_ii, [1, 1, 1, 1], [1, 1, 1, 1], avf, avl, v1, v2, v3, v4, v5, v6);
    qrs_data.median_12L = qrs_scoring_ecg;


    % adjust index for females
    if gender == 'F'
        adjust = qrs_data.lead_morph;
        adjust = adjust.adjustLocProperties(adjust);
        qrs_data.lead_morph = adjust;
    end
    

    % RS segment
    rs_seg = data.median_12L.V1(data.lead_morph.V1_r_loc: data.lead_morph.V1_s_loc);
    rs_slope = mean(diff(rs_seg));

    fprintf('RS slope is %d \n', rs_slope);

    fprintf('QRS interval is %d \n', data.geh.qrs_int);

    fprintf('QRS axis is %d', data.lead_morph.qrs_frontal_axis);

    % if checks

    % negative deflection
    if rs_slope < 0
        irregular_qrs = qrs_notching_slurring_check(qrs_data)
    
        if irregular_qrs == true && gender == 'M' && qrs_data.geh.qrs_int >= 140
            category = 'LBBB'
    
        elseif irregular_qrs == true && gender == 'F' && qrs_data.geh.qrs_int >= 130
            category = 'LBBB'
    
        else
            if lafb_check(gender, qrs_data.geh.qrs_int, qrs_data.lead_morph.qrs_frontal_axis) == true
                category = 'LAFB'
                
            else
                if lvh_check(gender, qrs_data.lead_morph.cornell_lvh_mv) == true
                    category = 'LVH'
                    
                else
                    category = 'No confounders'
                    
                end
            end
    
        end
    
    % positive deflection
    else
        if qrs_data.geh.qrs_int >= 120
            if qrs_data.lead_morph.qrs_frontal_axis <= 45 && qrs_data.lead_morph.qrs_frontal_axis > -180
                category = 'RBBB+LAFB'
                
            else
                category = 'RBBB'
                
            end
       
        else
            if lafb_check(gender, qrs_data.geh.qrs_int, qrs_data.lead_morph.qrs_frontal_axis) == true
                category = 'LAFB'
                
            else
                if lvh_check(gender, qrs_data.lead_morph.cornell_lvh_mv) == true
                    category = 'LVH'
                    
                else
                    category = 'No confounders'
                    
                end  
    
            end
    
        end
    
    end

    % Category-specific checks
    MIsz = qrs_scoring(qrs_data, category);

    % Post checks & score (RAO)
    % figure;
    % plot(v1)
    % 
    % figure;
    % plot(avf)
    
    userInput = input('Pasued for RAO checks [enter 0 or 1]:  ');
    MIsz = MIsz + rao_check(v1, v2, qrs_data.selvester_prep, qrs_data.lead_morph, userInput, category)
    


end