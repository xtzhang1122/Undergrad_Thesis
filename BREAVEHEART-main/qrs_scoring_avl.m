function [score] = qrs_scoring_avl(adjusted_data, category)

% computes QRS score specifically for avL for all categories except for
% LBBB

    score = 0;
    
    switch category
        case {'RBBB', 'No confounders'}
            if adjusted_data.selvester_prep.avL_Q_duration >= 30
               score = score + 1;
           end

        case {'LAFB', 'LAFB+RBBB', 'LVH'}
            if adjusted_data.selvester_prep.avL_Q_duration >= 40
               score = score + 1;
           end
    end

    if adjusted_data.selvester_prep.avL_rq_ratio <= 1
       score = score + 1;
    end

end