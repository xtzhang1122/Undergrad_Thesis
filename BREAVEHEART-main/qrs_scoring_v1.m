function [score] = qrs_scoring_v1(adjusted_data, category)

% computes QRS score specifically for V1 for all categories except for
% LBBB

    score = 0;
    
    switch category
        case 'RBBB'
            if adjusted_data.selvester_prep.V1_Q_duration >= 50
               score = score + 2;
            end

            % any Q
            if adjusted_data.selvester_prep.V1_Q_duration > 0
               score = score + 1;
            end

            % Init R
            if adjusted_data.selvester_prep.V1_R_duration <= 20
                score = score + 1;
            end

        case 'LAFB'
            % any QR
            if adjusted_data.selvester_prep.V1_Q_duration > 0 && adjusted_data.selvester_prep.V1_R_duration > 0
                score = score + 1;
            end

        case 'LAFB+RBBB'
           if adjusted_data.selvester_prep.V1_Q_duration >= 50
               score = score + 2;
           end
        
           % any Q
           if adjusted_data.selvester_prep.V1_Q_duration > 0
               score = score + 1;
           end

        case 'LVH'
            % any QR or any Q if nchinit40_check
            if adjusted_data.selvester_prep.V1_Q_duration > 0 && adjusted_data.selvester_prep.V1_R_duration > 0
                score = score + 1;
            end

            score = score + nchinit40_check(adjusted_data.median_12L.V1);

        case 'No confounders'
            % any Q
           if adjusted_data.selvester_prep.V1_Q_duration > 0
               score = score + 1;
           end
            
    end

end