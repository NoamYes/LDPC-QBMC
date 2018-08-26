%% the function gets the Matrix of varCheck, H mat, the var vector and QM
% it checks each variable in each check what is the value of the other vars
% and if they are all 0, Matrix in that check and var will be 0, else QM.

function [Mat] = var2check(Mat, H, var)

    [row, ~] = size(H);
    for check = 1:row %run on all the checks
        var_loc = find(~(H(check, :) - 1)); %find the location of the 1's
        % in the cheack equation in H.
        for idx = var_loc %run on all the variables in the check
            tmp_vec = H(check, :);
            tmp_vec(idx) = 0; %remove the 1 of variable var_loc, so we can check him            
            if tmp_vec * var.' == 0 %if all the other vars in check are 0
                Mat(check, idx) = 0; %put in zero in the matrix
            end
        end
    end
end