function [out_vec] = iter2(H, vec, QM)
    Field = 2;
    out_vec = vec;
    QM_vec = ( vec - QM2null(vec, QM) ).';
    change_vec = find(~(H*QM_vec-QM)); %find the locations of 'lonely' question marks
    
    for i = 1:length(change_vec)
        tmp = ~(H(change_vec(i),:).*vec-QM); %find the location of the lone question mark in the original vector
        %% not cheating:
        log_vec = H(change_vec(i),:); %get the i-th check in the matrix H
        log_vec(tmp) = 0; %remove the the QM
        mod_vec = mod(vec*log_vec.', Field); %calc the sum of the check w/o
        % the lone QM
        out_vec(tmp) = mod(Field - mod_vec, Field); %calc the value of the
        % QM so that the check is 0 (= Field)
    end
end
