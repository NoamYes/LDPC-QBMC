function [W_approx] = w_comp(Z, PiMat, q, dc)

    size = 1+log2(q);
    W_approx = zeros(1, size);
    vec_ndims = dc-1;
    vec_mat_size = size*ones(1,vec_ndims);
    
    for idx = 1:numel(W_approx)
        sum = 0;
        for idx_vec = 1:size^vec_ndims
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            Jordi = Z(sub_idx_vec);
            size_vec = 2.^(sub_idx_vec - 1);
            H_idx = num2cell(sub_idx_vec);
            tmp_PiVec = PiMat(H_idx{:});
            sum = sum + prod(Jordi)*tmp_PiVec{1}(idx); %%% CHECK THAT OUT (CAPS FOR DORE)
        end
        W_approx(idx) = sum;
    end
end

