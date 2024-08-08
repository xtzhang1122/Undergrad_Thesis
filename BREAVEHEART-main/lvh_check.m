function [satisfied] = lvh_check(gender, cornell_lvh_mv)

    if gender == 'M' && cornell_lvh_mv > 2.8
        satisfied = true;
    elseif gender == 'F' && cornell_lvh_mv > 2
        satisfied = true;
    end

    satisfied = false;
    
end