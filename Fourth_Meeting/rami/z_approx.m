function [Z] = z_approx(W, t, dv, size_distro, var, e_vec)

    Z = zeros(1,t);
    vec_ndims = dc-1;
    vec_mat_size = t*ones(1,dv-1);
    
    for idx = 1:t
        sum_e = 0;
        for e = 1:numel(e_vec)
            sum = 0;
            for idx_vec = 1:t^(dv-1)
              %  tic
                I = cell(1, vec_ndims); 
                [I{:}] = ind2sub(vec_mat_size,idx_vec);
                sub_idx_vec = cell2mat(I);
                Jordi = W(sub_idx_vec);
                sum = sum + prod(Jordi)*(var.*size_distro(idx,:)); %%% CHECK THAT OUT (CAPS FOR DORE)
               % toc;
            end
            sum_e = sum_e + e_vec(e)*sum;
        end
        Z(idx) = sum_e;
    end
end

