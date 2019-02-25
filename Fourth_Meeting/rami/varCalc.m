function [variable] = varCalc(t, q, dv, subsetsLen)

variable = zeros(1, q);
vec_ndims = dv-1;
vec_mat_size = t*ones(1,dv-1);
    for idx_vec = 1:t^(dv-1)
    %       tic
            I = cell(1, vec_ndims); 
            [I{:}] = ind2sub(vec_mat_size,idx_vec);
            sub_idx_vec = cell2mat(I);
            H_idx = num2cell(sub_idx_vec);
            minSize = min(subsetsLen(cell2mat(H_idx)));
            variable(minSize) = variable(minSize) + 1;
    %        toc;
    end
end

