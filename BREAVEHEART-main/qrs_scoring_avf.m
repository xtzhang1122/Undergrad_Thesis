function [score] = qrs_scoring_avf(adjusted_data, category)

% computes QRS score specifically for avF for all categories except for
% LBBB

    score = 0;
    
    switch category
        case {'RBBB', 'No confounders', 'LAFB', 'LAFB+RBBB'}
            if adjusted_data.selvester_prep.avF_Q_duration >= 50
               score = score + 3;
           end
        
           if adjusted_data.selvester_prep.avF_Q_duration >= 40
               score = score + 2;
           end
        
           if adjusted_data.selvester_prep.avF_Q_duration >= 30
               score = score + 1;
           end

        case {'LVH'}
            if adjusted_data.selvester_prep.avF_Q_duration >= 60
               score = score + 3;
           end
        
           if adjusted_data.selvester_prep.avF_Q_duration >= 50
               score = score + 2;
           end
        
           if adjusted_data.selvester_prep.avF_Q_duration >= 40
               score = score + 1;
           end
            
    end

    if adjusted_data.selvester_prep.avF_rq_ratio <= 1
       score = score + 2;
   end

   if adjusted_data.selvester_prep.avF_rq_ratio <= 2
       score = score + 1;
   end

end