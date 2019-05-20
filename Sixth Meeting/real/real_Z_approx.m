function [Z_approx] = real_Z_approx(q, dv, W, eps) 
size = 1+log2(q);
Z_approx = zeros(1, size);

for m = 1:numel(Z_approx)
    Z_m = 0;
    for i = 2:dv
        lambda = 1 / (1 + 2); % we assume n/k = 2
        sum = 0;
        vec_ndims = i-1;
        vec_mat_size = size*ones(1,vec_ndims);
        for k_tag = 1:size^vec_ndims
            I = cell(1, vec_ndims);
            [I{:}] = ind2sub(vec_mat_size,k_tag);
            sub_idx_vec = cell2mat(I);
            size_vec = 2.^(sub_idx_vec - 1);
            w_prod = prod(W(sub_idx_vec));

            Q = Q_calc(q, size_vec);
            sum = sum + w_prod * Q(m);
        end
        Z_m = Z_m + lambda * sum;
        sum = 0;
    end
    Z_approx(m) = eps * Z_m + (1 - eps) * (m == 1);
    Z_m = 0;
end

end
