function [W_approx] = real_W_approx(q,dc,Z) 
size = 1+log2(q);
W_approx = zeros(1, size);

for m = 1:numel(W_approx)
    W_m = 0;
    for i = 2:dc
        rho = 2 / (1 + 2); % we assume n/k = 2
        sum = 0;
        vec_ndims = i-1;
        vec_mat_size = size*ones(1,vec_ndims);
        for k_tag = 1:size^vec_ndims
            I = cell(1, vec_ndims);
            [I{:}] = ind2sub(vec_mat_size,k_tag);
            sub_idx_vec = cell2mat(I);
            size_vec = 2.^(sub_idx_vec - 1);
            z_prod = prod(Z(sub_idx_vec));
            
            P = P_calc(q, size_vec);
            sum = sum + z_prod * P(m);
        end
        W_m = W_m + rho * sum;
        sum = 0;
    end
    W_approx(m) = W_m;
    W_m = 0;
end

end
