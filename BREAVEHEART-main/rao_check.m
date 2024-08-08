function [score] = rao_check(v1, v2, qrs_scores, lead_morph, user_input, category)

    score = 0;
    % disp(lead_morph.V2_q_loc)
    % disp(lead_morph.V2_s_loc)
    
    if user_input ~= 0
        
        switch category
            case {'RBBB', 'LAFB+RBBB'} % Init R
                % V1
                if qrs_scores.V1_R_duration >= 60
                    score = score + 2;
                end
    
                if v1(lead_morph.V1_r_loc) >= 1.5
                    score = score + 2;
                end
    
                if qrs_scores.V1_R_duration >= 50
                    score = score + 1;
                end
    
                if v1(lead_morph.V1_r_loc) >= 1
                    score = score + 1;
                end
        
                % V2
                if qrs_scores.V2_R_duration >= 70
                    score = score + 2;
                end
    
                if v2(lead_morph.V2_r_loc) >= 2.5
                    score = score + 2;
                end
    
                if qrs_scores.V2_R_duration >= 50
                    score = score + 1;
                end
    
                if v2(lead_morph.V2_r_loc) >= 2
                    score = score + 1;
                end
    
    
            case {'LAFB', 'LVH', 'No confounders'}
                % V1
                if lead_morph.V1_rs_ratio >= 1
                    score = score + 1;
                end
    
                if qrs_scores.V1_R_duration >= 50
                    score = score + 2;
                end
    
                if v1(lead_morph.V1_r_loc) >= 1
                    score = score + 2;
                end
    
                if qrs_scores.V1_R_duration >= 40
                    score = score + 1;
                end
    
                if v1(lead_morph.V1_r_loc) >= 0.7
                    score = score + 1;
                end
    
                if abs(v1(lead_morph.V1_q_loc)) <= 0.2 && abs(v1(lead_morph.V1_s_loc)) <= 0.2
                    score = score + 1;
                end
     
                % V2
                if lead_morph.V2_rs_ratio >= 1.5
                    score = score + 1;
                end
    
                if qrs_scores.V2_R_duration >= 60
                    score = score + 2;
                end
    
                if v2(lead_morph.V2_r_loc) >= 2
                    score = score + 2;
                end
    
                if qrs_scores.V2_R_duration >= 50
                    score = score + 1;
                end
    
                if v2(lead_morph.V2_r_loc) >= 1.5
                    score = score + 1;
                end
    
                if abs(v2(lead_morph.V2_q_loc)) <= 0.3 && abs(v2(lead_morph.V2_s_loc)) <= 0.3
                    score = score + 1;
                end
    
    
            case 'LBBB'
                % V1
                score = score + nchinit40_check(v1);
    
                if qrs_scores.V1_R_duration >= 30
                    score = score + 2;
                end
    
                if v1(lead_morph.V1_r_loc) >= 0.3
                    score = score + 2;
                end
    
                if qrs_scores.V1_R_duration >= 20
                    score = score + 1;
                end
    
                if v1(lead_morph.V1_r_loc) >= 0.2
                    score = score + 1;
                end
    
                % V2
                score = score + nchinit40_check(v2);
    
                if qrs_scores.V2_R_duration >= 30
                    score = score + 2;
                end
    
                if v2(lead_morph.V2_r_loc) >= 0.4
                    score = score + 2;
                end
    
                if qrs_scores.V2_R_duration >= 20
                    score = score + 1;
                end
    
                if v2(lead_morph.V2_r_loc) >= 0.3
                    score = score + 1;
                end
    
            otherwise
                fprintf('Not a valid category for QRS scoring: received %s', category);
        end
          
    end

end