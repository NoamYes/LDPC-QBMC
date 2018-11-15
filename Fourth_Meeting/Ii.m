function [IiMat] = Ii(t, q, dv, intersectMat) 
    % IiMat is a t matrix of dimension dv (aka t x t x t dv times)
    % 
    set_vec = t*ones(1, dv-1);
    set_mat = zeros(set_vec);
    
    vec_ndims = ndims(set_mat);
    vec_mat_size = size(set_mat);
    
    IiMat = cell(set_vec);

    for idx_vec = 1:numel(set_mat)
      %  tic
        I = cell(1, vec_ndims); 
        [I{:}] = ind2sub(vec_mat_size,idx_vec);
        sub_idx_vec = cell2mat(I);
        idxCell = num2cell(sub_idx_vec);
        inter = two2one(q, sub_idx_vec, intersectMat);
        i_vec = zeros(1,t);
        i_vec(inter) = 1;
        IiMat{idxCell{:}} = i_vec;
       % toc;
    end
end