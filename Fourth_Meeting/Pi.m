function [PiMat] = Pi(t, q, L_vec, dc, looktable, dividetable) 
    % PiMat is a t matrix of dimension dc (aka t x t x t dc times)
    % 
    set_vec = t*ones(1, dc-1);
%     pi_vec = t*ones(1, dc);
%     const_vec = (q-1)*ones(1, dc);
    
    probMat = probMatrix(q, dc, L_vec);
    set_mat = zeros(set_vec);
    
    vec_ndims = ndims(set_mat);
    vec_mat_size = size(set_mat);
    const_ndims = ndims(probMat);
    const_mat_size = size(probMat);
    
    PiMat = cell(set_vec);

    
    for idx_vec = 1:numel(set_mat)
        tic
        I = cell(1, vec_ndims); 
        [I{:}] = ind2sub(vec_mat_size,idx_vec);
        sub_idx_vec = cell2mat(I);
        
        set_hist = zeros(1, t);
        for idx_const = 1:numel(probMat)
            J = cell(1, const_ndims); 
            [J{:}] = ind2sub(const_mat_size,idx_const);
            sub_idx_const = cell2mat(J);
            
            result = five2one(sub_idx_vec, sub_idx_const, dc, looktable, dividetable);
            set_hist(result) = set_hist(result) + probMat(idx_const);
        end
        idxCell = num2cell(sub_idx_vec);
        PiMat{idxCell{:}} = set_hist;
        toc;
    end
end