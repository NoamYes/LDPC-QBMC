%% the function gets the Matrix and a var vector full of q-1 values, and log2(q)
%  the function returns the check2var calculation

function [v2c] = var2check(H,c2v, v2c_s, c2v_s,q)
    tic
    
    mat = zeros(size(H)); 
    mat(c2v_s.idxs) = c2v; % map from c2v matrix to v2c matrix
    v2c_tmp = mat(v2c_s.idxs); % ^
    masked_mat = repmat(v2c_tmp, [1,1, size(v2c_tmp,2)]);
    for i = 1:size(v2c_tmp,2)
        masked_mat(:,i,i) = q; % mask dv times with q vector to take every c2v except c'
    end
    v2c = min(masked_mat,[],2); % the minimum is the intersection
    v2c = squeeze(v2c);
    
    toc;
end
