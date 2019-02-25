function [W] = w_comp2(Z, t,q, Pi_len_cell, dc, looktable, dividetable, subsetsLen)

    W = zeros(1,numel(Z));
    vec_ndims = dc-1;
    vec_mat_size = t*ones(1,dc-1);
    for idx = 1:numel(W)
        sum = 0;
        for idx_vec = 1:t^(dc-1)
%            tic
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            Jordi = Z(sub_idx_vec);
            H_idx = num2cell(sub_idx_vec);
%             len = length(five2one(cell2mat(H_idx), ones(1,dc), dc, looktable, dividetable));
            len = min(q,prod(subsetsLen(cell2mat(H_idx))));
            tmp_PiVec = Pi_len_cell{len};
            sum = sum + prod(Jordi)*tmp_PiVec(idx); %%% CHECK THAT OUT (CAPS FOR DORE)
%            toc;
        end
        W(idx) = sum;
    end


end



