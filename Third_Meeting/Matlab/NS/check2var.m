%% the function gets the Matrix of varCheck, H mat, the var vector and QM
% it checks each variable in each check what is the value of the other vars
% and if they are all 0, Matrix in that check and var will be 0, else QM.

function [c2v] = check2var(H, v2c, v2c_s, c2v_s)
    tic
    mat = zeros(size(H));
    mat(v2c_s.idxs) = v2c;
    c2v = mat(c2v_s.idxs);
    toc;
    







%     one_loc = find(~(H_t - 1)); %find the location of ones in H
%     for i = 1:dc
%         dc_loc = one_loc(i:dc:end); %get the one_loc in i mod dc locations
%         H_t(dc_loc) = 0; %put 0's where they should be
%         mat_row = ~(var * H_t);  %find the location of zeros in var * H_t
%         Mat_t(dc_loc(mat_row)) = 0; %put 0 in the var2check matrix
%         H_t(dc_loc) = 1; %put 1s where they used to be
%     end
  
end

