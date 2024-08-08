function [score] = lbbb_criteria(adjusted_data)
    
    score = 0;

    % L1
    % any Q
    if adjusted_data.selvester_prep.L1_Q_duration > 0
        score = score + 1;
    end

    if adjusted_data.selvester_prep.L1_rq_ratio <= 1
        score = score + 2;
    end

    if adjusted_data.lead_morph.L1_rs_ratio <= 1
        score = score + 2;
    end

    if adjusted_data.selvester_prep.L1_rq_ratio <= 1.5
        score = score + 1;
    end

    if adjusted_data.lead_morph.L1_rs_ratio <= 1.5
        score = score + 1;
    end


    % L2
    if adjusted_data.selvester_prep.L2_Q_duration >= 40
        score = score + 2;
    end

    if adjusted_data.selvester_prep.L2_Q_duration >= 30
        score = score + 1;
    end

    if adjusted_data.selvester_prep.L2_rq_ratio <= 0.5
        score = score + 1;
    end

    if adjusted_data.lead_morph.L2_rs_ratio <= 0.5
        score = score + 1;
    end

    
   % avL
   if adjusted_data.selvester_prep.avL_Q_duration >= 50
       score = score + 2;
   end

   if adjusted_data.selvester_prep.avL_Q_duration >= 40
       score = score + 1;
   end

   if adjusted_data.selvester_prep.avL_rq_ratio <= 0.5
       score = score + 2;
   end

   if adjusted_data.lead_morph.avL_rs_ratio <= 0.5
       score = score + 2;
   end

   if adjusted_data.selvester_prep.avL_rq_ratio <= 1
       score = score + 1;
   end

   if adjusted_data.lead_morph.avL_rs_ratio <= 1
       score = score + 1;
   end


   % avF
   if adjusted_data.selvester_prep.avF_Q_duration >= 50
       score = score + 2;
   end

   if adjusted_data.selvester_prep.avF_Q_duration >= 40
       score = score + 1;
   end
   
   if adjusted_data.selvester_prep.avF_rq_ratio <= 0.5
       score = score + 1;
   end

   if adjusted_data.lead_morph.avF_rs_ratio <= 0.5
       score = score + 1;
   end


   % V1 (post)
   S_range = adjusted_data.median_12L.V1(adjusted_data.lead_morph.V1_r_loc + 5: adjusted_data.lead_morph.V1_t_loc);
   [pks, ~] = findpeaks(-S_range);
   sortedArray = sort(pks, 'descend');

   if length(locs) > 1
        ss_ratio = abs(sortedArray(1) / sortedArray(2));

        if ss_ratio >= 2
            score = score + 3;
        end

        if ss_ratio >= 1.5
            score = score + 2;
        end

        if ss_ratio >= 1.25
            score = score + 1;
        end
   end

   
   % V2 (post)
   S_range = adjusted_data.median_12L.V2(adjusted_data.lead_morph.V2_r_loc + 5: adjusted_data.lead_morph.V2_t_loc);
   [pks, ~] = findpeaks(-S_range);
   sortedArray = sort(pks, 'descend');

   if length(locs) > 1
        ss_ratio = abs(sortedArray(1) / sortedArray(2));

        if ss_ratio >= 2.5
            score = score + 3;
        end

        if ss_ratio >= 2
            score = score + 2;
        end

        if ss_ratio >= 1.5
            score = score + 1;
        end
   end


   % V5
   % any Q
   if adjusted_data.selvester_prep.V5_Q_duration > 0
       score = score + 1;
   end
   
   R_range = adjusted_data.median_12L.V5(adjusted_data.lead_morph.V5_q_loc + 5: adjusted_data.lead_morph.V2_s_loc);
   [pks, ~] = findpeaks(R_range);
   sortedArray = sort(pks, 'descend');

   if length(locs) > 1
        rr_ratio = abs(sortedArray(1) / sortedArray(2));

        if rr_ratio >= 2
            score = score + 2;
        end

        if rr_ratio >= 1
            score = score + 1;
        end
   end

   if adjusted_data.median_12L.V5(adjusted_data.lead_morph.V5_r_loc) <= 0.5
       score = score + 1;
   end


   % V6
   if adjusted_data.selvester_prep.V6_Q_duration >= 20
       score = score + 1;
   end
   
   R_range = adjusted_data.median_12L.V6(adjusted_data.lead_morph.V6_q_loc + 5: adjusted_data.lead_morph.V6_s_loc);
   [pks, ~] = findpeaks(R_range);
   sortedArray = sort(pks, 'descend');

   if length(locs) > 1
        rr_ratio = abs(sortedArray(1) / sortedArray(2));

        if rr_ratio >= 2
            score = score + 2;
        end

        if rr_ratio >= 1
            score = score + 1;
        end
   end

   if adjusted_data.median_12L.V6(adjusted_data.lead_morph.V6_r_loc) <= 0.6
       score = score + 1;
   end
    

end