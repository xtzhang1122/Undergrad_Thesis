function [score] = qrs_scoring(adjusted_data, category)
    
    % follows QRS Scoring Sheet for computing QRS Score (except for LBBB, V1 Post and V2 Post)
    % Lead I, II and V4 all follow the same criterias
    % all other leads are computed by calling other functions

    score = 0;

    % L1
    if adjusted_data.selvester_prep.L1_Q_duration >= 30
        score = score + 1;
    end

    if adjusted_data.selvester_prep.L1_rq_ratio <= 1
        score = score + 1;
    end

    if adjusted_data.median_12L.I(adjusted_data.lead_morph.L1_r_loc) <= 0.2
        score = score + 1;
    end


    % L2
    if adjusted_data.selvester_prep.L2_Q_duration >= 40
        score = score + 2;
    end

    if adjusted_data.selvester_prep.L2_Q_duration >= 30
        score = score + 1;
    end

    
   % avL
   score = score + qrs_scoring_avl(adjusted_data, category);

   % avF
   score = score + qrs_scoring_avf(adjusted_data, category);

   % V1
   score = score + qrs_scoring_v1(adjusted_data, category);

   % V2
   score = score + qrs_scoring_v2(adjusted_data, category);
   
   % V3
   score = score + qrs_scoring_v3(adjusted_data, category);

   % V4
   if adjusted_data.selvester_prep.V4_Q_duration >= 20
       score = score + 1;
   end

   if adjusted_data.selvester_prep.V4_rq_ratio <= 0.5
       score = score + 2;
   end

   if adjusted_data.lead_morph.V4_rs_ratio <= 0.5
       score = score + 2;
   end

   if adjusted_data.selvester_prep.V4_rq_ratio <= 1
       score = score + 1;
   end

   if adjusted_data.lead_morph.V4_rs_ratio <= 1
       score = score + 1;
   end

   if adjusted_data.median_12L.V4(adjusted_data.lead_morph.V4_r_loc) <= 0.5
       score = score + 1;
   end

   score = score + nchinit40_check(adjusted_data.median_12L.V4);

   % V5
   score = score + qrs_scoring_v5(adjusted_data, category);

   % V6
   score = score + qrs_scoring_v6(adjusted_data, category);
   
end