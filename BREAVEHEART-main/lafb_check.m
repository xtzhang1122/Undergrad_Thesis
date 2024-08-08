function [satisfied] = lafb_check(gender, qrs_int, qrs_frontal_axis)

    if gender == 'M' && qrs_int >= 100 && qrs_frontal_axis <= -45
        satisfied = true;
    elseif gender == 'F' && qrs_int >= 90 && qrs_frontal_axis <= -45
        satisfied = true;
    end

    satisfied = false;
    
end