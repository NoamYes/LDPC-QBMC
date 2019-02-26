function [W] = w_approx(Z, q, dc, subsetsLen)

    size = 1+log2(q);
    W = zeros(1, size);
    vec_ndims = dc-1;
    vec_mat_size = size*ones(1,dc-1);
    for idx = 1:size
        sum = 0;
        for idx_vec = 1:size^(dc-1)
%            tic
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            H_idx = num2cell(sub_idx_vec);
            multiSize = prod(subsetsLen(cell2mat(H_idx)));
            if multiSize >= q
                multiSize = q;
            end            
            if multiSize == 2^(idx-1)
                Jordi = Z(sub_idx_vec);
                sum = sum + prod(Jordi);
            end
%            toc;
        end
        W(idx) = sum;
    end

end