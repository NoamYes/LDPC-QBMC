function [Z] = z_approx(W, q, dv, e_vec, subsetsLen)

    size = 1+log2(q);
    Z = zeros(1,size);
    vec_ndims = dv-1;
    vec_mat_size = size*ones(1,dv-1);
    
    for idx = 1:size
        sum_e = 0;
        for e = 1:numel(e_vec)
            sum = 0;
            for idx_vec = 1:size^(dv-1)
              %  tic
                I = cell(1, vec_ndims); 
                [I{:}] = ind2sub(vec_mat_size,idx_vec);
                sub_idx_vec = cell2mat(I);
                H_idx = num2cell(sub_idx_vec);
                minSize = min(subsetsLen(cell2mat(H_idx)));
                if minSize == 2^(idx-1)
                    Jordi = W(sub_idx_vec);
                    sum = sum + prod(Jordi);
                end
               % toc;
            end
            sum_e = sum_e + e_vec(e)*sum;
        end
        Z(idx) = sum_e;
    end
end

