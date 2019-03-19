function [W] = w_approx(Z, q, dc)

    size = 1+log2(q);
    W = zeros(1, size);
    vec_ndims = dc-1;
    vec_mat_size = size*ones(1,dc-1);

    for idx_vec = 1:size^(dc-1)
        I = cell(1, vec_ndims); 
        [I{:}] = ind2sub(vec_mat_size,idx_vec);
        sub_idx_vec = cell2mat(I);
        size_vec = 2.^(sub_idx_vec - 1);
        multiSize = prod(size_vec);
        if multiSize >= q
            multiSize = q;
        end   
        Jordi = Z(sub_idx_vec);
        W(log2(multiSize) + 1) = W(log2(multiSize) + 1) + prod(Jordi);
    end
end