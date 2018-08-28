%% the function gets the Matrix and a var vector full of q-1 values, and log2(q)
%  the function returns the check2var calculation

function [var] = check2var(Mat_t, var, logq)

%     gf_mat = gf(Mat_t,logq); %turns mat to gf mat
    for i = logq:-1:1
        
        [QM_row, ~] = find(~(Mat_t - (2^(i - 1) - 1))); %find values that are 2^(i - 1) - 1
        var(QM_row) = 2^(i - 1) - 1; %if there are 2^(i - 1) - 1)'s in the col, then put a 2^(i - 1) - 1) in the var

    end
end
