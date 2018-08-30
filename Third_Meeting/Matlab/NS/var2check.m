%% the function gets the Matrix and a var vector full of q-1 values, and log2(q)
%  the function returns the check2var calculation

function [v2c] = var2check(H,c2v, v2c_s, c2v_s)
    tic
    mat = zeros(size(H));
    mat(c2v_s.idxs) = c2v;
    v2c_tmp = mat(v2c_s.idxs);
    mask_mat = repmat(v2c_tmp, [1,1, size(v2c_tmp,2)]);
    for i = 1:size(v2c_tmp,2)
        mask_mat(:,i,i) = 0;
    end
    toc;
end
