function [Mat] = var2check(H, var, Field)

        H 
        

        tmp = ~(H(change_vec(i),:).*vec-QM); %find the location of the lone question mark in the original vector
        %% not cheating:
        log_vec = H(change_vec(i),:); %get the i-th check in the matrix H
        log_vec(tmp) = 0; %remove the the QM
        mod_vec = mod(vec*log_vec.', Field); %calc the sum of the check w/o
end


