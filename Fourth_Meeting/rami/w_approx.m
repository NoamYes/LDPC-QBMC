function [W] = w_approx(Z, t, dc, size_distro, check)

    W = zeros(1,t);
    vec_ndims = dc-1;
    vec_mat_size = t*ones(1,dc-1);
    for idx = 1:t
        sum = 0;
        for idx_vec = 1:t^(dc-1)
%            tic
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            Jordi = Z(sub_idx_vec);
            sum = sum + prod(Jordi)*(check.*size_distro(idx,:)); %%% CHECK THAT OUT (CAPS FOR DORE)
%            toc;
        end
        sum
        W(idx) = sum;
    end

end