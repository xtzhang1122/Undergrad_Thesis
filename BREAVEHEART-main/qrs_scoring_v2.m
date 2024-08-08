function [score] = qrs_scoring_v2(adjusted_data, category)

% computes QRS score specifically for V2 for all categories except for
% LBBB

    score = 0;
    
    switch category
        case {'RBBB', 'LAFB+RBBB'}
            if adjusted_data.selvester_prep.V2_Q_duration >= 50
               score = score + 2;
            end

            % any Q
            if adjusted_data.selvester_prep.V2_Q_duration > 0
               score = score + 1;
            end

            if adjusted_data.selvester_prep.V2_R_duration <= 10
                score = score + 1;
            end

            if adjusted_data.median_12L.V2(adjusted_data.lead_morph.V2_r_loc) <= 0.1
               score = score + 1;
           end


        case 'LAFB'
            % any QR
            if adjusted_data.selvester_prep.V2_Q_duration > 0 && adjusted_data.selvester_prep.V2_R_duration > 0
                score = score + 1;
            end

            if adjusted_data.selvester_prep.V2_R_duration <= 10
                score = score + 1;
            end

            if adjusted_data.median_12L.V2(adjusted_data.lead_morph.V2_r_loc) <= 0.1
               score = score + 1;
            end


        case 'LVH'
            % any QR or any Q if nchinit40_check
            if adjusted_data.selvester_prep.V2_Q_duration > 0 && adjusted_data.selvester_prep.V2_R_duration > 0
                score = score + 1;
            end

            score = score + nchinit40_check(adjusted_data.median_12L.V2);

        case 'No confounders'
            % any Q
           if adjusted_data.selvester_prep.V2_Q_duration > 0
               score = score + 1;
           end

           if adjusted_data.selvester_prep.V2_R_duration <= 10
                score = score + 1;
            end

            if adjusted_data.median_12L.V2(adjusted_data.lead_morph.V2_r_loc) <= 0.1
               score = score + 1;
           end
            
    end

end