function [score] = qrs_scoring_v6(adjusted_data, category)

% computes QRS score specifically for V6 for all categories except for
% LBBB

    score = 0;

    if adjusted_data.selvester_prep.V6_Q_duration >= 30
       score = score + 1;
   end
   
   if adjusted_data.selvester_prep.V6_rq_ratio <= 1
       score = score + 2;
   end

   if adjusted_data.lead_morph.V6_rs_ratio <= 1
       score = score + 2;
   end

   if adjusted_data.selvester_prep.V6_rq_ratio <= 3
       score = score + 1;
   end
    
    switch category
        case {'RBBB', 'LVH', 'No confounders'}
            if adjusted_data.lead_morph.V6_rs_ratio <= 3
               score = score + 1;
           end


        case {'LAFB','LAFB+RBBB'}
            if adjusted_data.lead_morph.V6_rs_ratio <= 2
               score = score + 1;
           end

    end

    if adjusted_data.median_12L.V6(adjusted_data.lead_morph.V6_r_loc) <= 0.6
       score = score + 1;
   end

   score = score + nchinit40_check(adjusted_data.median_12L.V6);

end