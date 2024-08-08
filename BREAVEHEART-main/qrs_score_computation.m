function [Q_duration, R_duration, rq_ratio] = qrs_score_computation(signal, Q_index, R_index, S_index, gender)
    
    % Q duration
    % disp(Q_index)
    % disp(R_index)
    absArray = abs(signal(1: Q_index));
    minValue = min(absArray);
    
    q_start = max(find(signal(1: Q_index) == minValue | signal(1: Q_index) == -minValue));

    
    absArray = abs(signal(Q_index: R_index));
    minValue = min(absArray);
    
    q_end = Q_index + find(signal(Q_index: R_index) == minValue | signal(Q_index: R_index) == -minValue, 1);
    
    Q_duration = (q_end - q_start) / 500 * 1000;

    if gender == 'F'
        Q_duration = Q_duration * 0.9;
    end

    % R duration
    r_start = q_end;

    absArray = abs(signal(R_index: S_index));
    minValue = min(absArray);
    
    r_end = R_index + find(signal(R_index: S_index) == minValue | signal(R_index: S_index) == -minValue, 1);

    R_duration = (r_end - r_start) / 500 * 1000;

    if gender == 'F'
        R_duration = R_duration * 0.9;
    end

    % R/Q ratio
    rq_ratio = abs(signal(R_index) / signal(Q_index));

    
    % print and check if values are reasonable
    fprintf('Q index: %d ; R_index: %d; S_index: %d; Q start: %d; Q end: %d; R start: %d; R end: %d; \n',Q_index, R_index, S_index, q_start, q_end, r_start, r_end);
    
end