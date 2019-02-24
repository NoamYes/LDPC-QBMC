function [check] = checkCalc(t, q, dc, subsetsLen)

check = zeros(1, q);
vec_ndims = dc-1;
vec_mat_size = t*ones(1,dc-1);
    for idx_vec = 1:t^(dc-1)
    %       tic
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            H_idx = num2cell(sub_idx_vec);
            multiSize = prod(subsetsLen(cell2mat(H_idx)));
            if multiSize >= q
                multiSize = q;
            end
            check(multiSize) = check(multiSize) + 1;
    %        toc;
    end
end

