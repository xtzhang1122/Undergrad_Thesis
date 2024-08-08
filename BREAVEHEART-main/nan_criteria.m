function [score] = nan_criteria(adjusted_data)
    
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
   if adjusted_data.selvester_prep.avL_Q_duration >= 30
       score = score + 1;
   end

   if adjusted_data.selvester_prep.avL_rq_ratio <= 1
       score = score + 1;
   end


   % avF
   if adjusted_data.selvester_prep.avF_Q_duration >= 50
       score = score + 3;
   end

   if adjusted_data.selvester_prep.avF_Q_duration >= 40
       score = score + 2;
   end

   if adjusted_data.selvester_prep.avF_Q_duration >= 30
       score = score + 1;
   end

   if adjusted_data.selvester_prep.avF_rq_ratio <= 1
       score = score + 2;
   end

   if adjusted_data.selvester_prep.avF_rq_ratio <= 2
       score = score + 1;
   end


   % V1
   if adjusted_data.selvester_prep.V1_Q_duration > 0
       score = score + 1;
   end


   % V2
   if adjusted_data.selvester_prep.V2_Q_duration > 0
       score = score + 1;
   end

   if adjusted_data.selvester_prep.V2_R_duration <= 10
       score = score + 1;
   end

   if adjusted_data.median_12L.V2(adjusted_data.lead_morph.V2_r_loc) <= 0.1
       score = score + 1;
   end


   % V3
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
   if adjusted_data.selvester_prep.V5_Q_duration >= 30
       score = score + 1;
   end
   
   if adjusted_data.selvester_prep.V5_rq_ratio <= 1
       score = score + 2;
   end

   if adjusted_data.lead_morph.V5_rs_ratio <= 1
       score = score + 2;
   end

   if adjusted_data.selvester_prep.V5_rq_ratio <= 2
       score = score + 1;
   end

   if adjusted_data.lead_morph.V5_rs_ratio <= 2
       score = score + 1;
   end

   if adjusted_data.median_12L.V5(adjusted_data.lead_morph.V5_r_loc) <= 0.6
       score = score + 1;
   end

   score = score + nchinit40_check(adjusted_data.median_12L.V5);


   % V6
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

   if adjusted_data.lead_morph.V6_rs_ratio <= 3
       score = score + 1;
   end

   if adjusted_data.median_12L.V6(adjusted_data.lead_morph.V6_r_loc) <= 0.6
       score = score + 1;
   end

   score = score + nchinit40_check(adjusted_data.median_12L.V6);
    

end