function [Z] = z_comp(W, Ii, e_vec)

    Z = zeros(1,numel(W));
    vec_ndims = ndims(Ii);
    vec_mat_size = size(Ii);
    
    for idx = numel(Z)
        sum_e = 0;
        for e = e_vec
            sum = 0;
            for idx_vec = 1:numel(Ii)
              %  tic
                I = cell(1, vec_ndims); 
                [I{:}] = ind2sub(vec_mat_size,idx_vec);
                sub_idx_vec = cell2mat(I);
                Jordi = W(sub_idx_vec);
                sum = sum + prod(Jordi)*Ii(sub_idx_vec);

               % toc;
            end
            sum_e = e*sum + sum_e;
        end
    end
end

