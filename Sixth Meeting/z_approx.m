function [Z] = z_approx(W, q, dv, e_vec)

size = 1+log2(q);
Z = zeros(1,size);
vec_ndims = dv-1;
vec_mat_size = size*ones(1,dv-1);

for idx = 1:numel(Z)
    sum_e = 0;
    for e = 1:numel(e_vec)
        sum = 0;
        for idx_vec = 1:size^(dv-1)
            tmp_IiVec = zeros(1,size);
            I = cell(1, vec_ndims);
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            size_vec = 2.^(sub_idx_vec - 1);
            minSize = min(size_vec);
            tmp_IiVec(minSize) = 1;
            Jordi = W(sub_idx_vec);
            sum = sum + prod(Jordi)*tmp_IiVec(idx);
            % Z(log2(minSize) + 1) = Z(log2(minSize) + 1) + prod(Jordi);
        end
        
        Z = Z.*e_vec;
        sum_e = e_vec(e)*sum + sum_e;
    end
    Z(idx) = sum_e;
end
end

