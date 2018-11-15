function [Z] = z_comp(W, Ii, e_vec)

    Z = zeros(1,numel(W));
    Ii_mat_size =  size(Ii);
    iterSize = Ii_mat_size(1:end-1);
    IteratorMat = zeros(iterSize);
        vec_ndims = ndims(IteratorMat);
    vec_mat_size = size(IteratorMat);
    
    for idx = 1:numel(Z)
        sum_e = 0;
        for e = e_vec
            sum = 0;
            for idx_vec = 1:numel(IteratorMat)
              %  tic
                I = cell(1, vec_ndims); 
                [I{:}] = ind2sub(vec_mat_size,idx_vec);
                sub_idx_vec = cell2mat(I);
                Jordi = W(sub_idx_vec);
                tmp_IiVec = Ii{sub_idx_vec};
                sum = sum + prod(Jordi)*tmp_IiVec(idx);

               % toc;
            end
            sum_e = e*sum + sum_e;
        end
        Z(idx) = sum_e;
    end
end

