function [check] = checkCalc2(q, dc)

%% same function as checkCalc but works with sizes = 2^m

maxS = log2(q)+1;
check = zeros(1, maxS);
vec_ndims = dc-1;
vec_mat_size = maxS*ones(1,dc-1);
    for idx_vec = 1:maxS^(dc-1)
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            H_idx = num2cell(2.^(sub_idx_vec-1));
            multiSize = prod((cell2mat(H_idx)));
            if multiSize >= q
                multiSize = q;
            end
            check(log2(multiSize)+1) = check(log2(multiSize)+1) + 1;
    end
end