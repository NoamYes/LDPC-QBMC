function [Z_approx] = z_comp(W, IiMat, q, dv, e_vec)

    size = 1+log2(q);
    Z_approx = zeros(1, size);
    vec_ndims = dv;
    vec_mat_size = size*ones(1,vec_ndims);
    
    for idx = 1:numel(Z_approx)
        sum_e = 0;
        for e = 1:numel(e_vec)
            sum = 0;
            for idx_vec = 1:size^vec_ndims
                I = cell(1, vec_ndims); 
                [I{:}] = ind2sub(vec_mat_size,idx_vec);
                sub_idx_vec = cell2mat(I);
                Jordi = W(sub_idx_vec);
                sub_idx_vec = [sub_idx_vec e]; % added "j"
                size_vec = 2.^(sub_idx_vec - 1);
%                 tmp_IiVec = Q_calc(q, size_vec);
                tmp_IiVec = IiMat{size_vec};
                sum = sum + prod(Jordi)*tmp_IiVec(idx); %%% CHECK THAT OUT (CAPS FOR DORE)
            end
            sum_e = sum_e + e_vec(e)*sum;
        end
        Z_approx(idx) = sum_e;
    end
end