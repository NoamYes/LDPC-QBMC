function [W_approx] = w_comp(Z, q, dc)

    size = 1+log2(q);
    W_approx = zeros(1, size);
    vec_ndims = dc;
    vec_mat_size = size*ones(1,vec_ndims);
    
    for idx = 1:numel(W_approx)
        sum = 0;
        for idx_vec = 1:size^vec_ndims
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            Jordi = Z(sub_idx_vec);
            size_vec = 2.^(sub_idx_vec - 1);
            tmp_PiVec = P_calc(q, size_vec);
            sum = sum + prod(Jordi)*tmp_PiVec(idx); %%% CHECK THAT OUT (CAPS FOR DORE)
        end
        W_approx(idx) = sum;
    end
end

