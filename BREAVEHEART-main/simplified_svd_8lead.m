function [PCA_Ratio] = simplified_svd_8lead(X)
    [~,~,V]=svd(X);
    s=svd(X);
    
    va = s.^2;
    variance = 100 * va / sum(va);
    
    var_s1_total = variance(1);
    var_s2_total = variance(2);
    
    PCA_Ratio = var_s2_total / var_s1_total;
end