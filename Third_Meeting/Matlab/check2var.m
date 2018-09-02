%% the function gets the Matrix of varCheck, H mat, the var vector and QM
% it checks each variable in each check what is the value of the other vars
% and if they are all 0, Matrix in that check and var will be 0, else QM.

function [Mat_t] = check2var(Mat_t, H_t, var, dc, looktable)
    
    not_zero = find(H_t); %find the location of not 0 in H_t
    for i = 1:dc
        dc_loc = not_zero(i:dc:end); %get the one_loc in i mod dc locations
        H_t(dc_loc) = 0; %put 0's where they should be for this iter
        Mat_t(dc_loc) = sum_lookup(looktable, H_t, var, dc);
        H_t(dc_loc) = 1; %put 1s where they used to be
    end
    
end

