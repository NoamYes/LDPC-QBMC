function [W] = w_comp(Z, Pi)

    W = zeros(1,numel(Z));
    vec_ndims = ndims(Pi);
    vec_mat_size = size(Pi);
    for idx = numel(W)
        sum = 0;
        for idx_vec = 1:numel(Pi)
          %  tic
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            Jordi = Z(sub_idx_vec);
            sum = sum + prod(Jordi)*Pi(sub_idx_vec);
           
           % toc;
        end
        W(idx) = sum;
    end


end

