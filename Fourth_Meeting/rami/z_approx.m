function [Z] = z_approx(W, q, dv, e_vec)

    size = 1+log2(q);
    Z = zeros(1,size);
    vec_ndims = dv-1;
    vec_mat_size = size*ones(1,dv-1);
   
    for idx_vec = 1:size^(dv-1)
        I = cell(1, vec_ndims); 
        [I{:}] = ind2sub(vec_mat_size,idx_vec);
        sub_idx_vec = cell2mat(I);
        size_vec = 2.^(sub_idx_vec - 1);
        minSize = min(size_vec);
        Jordi = W(sub_idx_vec);
        Z(log2(minSize) + 1) = Z(log2(minSize) + 1) + prod(Jordi);
    end
    
    Z = Z.*e_vec;
               
end

