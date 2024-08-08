function [score] = qrs_scoring_v3(adjusted_data, category)

% computes QRS score specifically for V3 for all categories except for
% LBBB

    score = 0;
    
    switch category
        case {'RBBB', 'LAFB','LAFB+RBBB', 'No confounders'}
            if adjusted_data.selvester_prep.V3_Q_duration >= 30
               score = score + 2;
           end
        
           if adjusted_data.selvester_prep.V3_R_duration <= 10
               score = score + 2;
           end
        
           if adjusted_data.selvester_prep.V3_Q_duration >= 20
               score = score + 1;
           end
        
           if adjusted_data.selvester_prep.V3_R_duration <= 20
               score = score + 1;
           end

        case 'LVH'
            if adjusted_data.selvester_prep.V3_Q_duration >= 30 && adjusted_data.selvester_prep.V3_R_duration > 0
                score = score + 2;
            end

            score = score + nchinit40_check(adjusted_data.median_12L.V3);
    
            % any QR
            if adjusted_data.selvester_prep.V3_Q_duration > 0 && adjusted_data.selvester_prep.V3_R_duration > 0
                score = score + 1;
            end

    end

end