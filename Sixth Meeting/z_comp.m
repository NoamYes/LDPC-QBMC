function [Z] = z_comp(W, q, dv, e_vec, Ii)

size = 1+log2(q);
Z = zeros(1,size);
vec_ndims = dv-1;
vec_mat_size = size*ones(1,dv-1);

    
    for idx = 1:numel(Z)
        sum_e = 0;
        for e = 1:numel(e_vec)
            sum = 0;
            for idx_vec = 1:size^(dv-1)
                %  tic
                I = cell(1, vec_ndims); 
                [I{:}] = ind2sub(vec_mat_size,idx_vec);
                sub_idx_vec = cell2mat(I);
                Jordi = W(sub_idx_vec);
                H_idx = num2cell([sub_idx_vec]);
                tmp_IiVec = Ii{H_idx{:}};
                sum = sum + prod(Jordi)*tmp_IiVec(idx); %%% CHECK THAT OUT (CAPS FOR DORE)

               % toc;
            end
            sum_e = e_vec(e)*sum + sum_e;
        end
        Z(idx) = sum_e;
    end
end