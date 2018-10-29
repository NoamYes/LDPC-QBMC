function [PiMat] = Pi(subCell, q, L_vec, dc) 
    t = length(subCell);
    set_vec = t*ones(1, dc-1);
    const_vec = (q-1)*ones(1, dc);
    L_Hist = zeros(const_vec);
    for idx_hist = const_vec
%         L_Hist(idx_hist) = L_vec[const_vec]
    end

    %piMat_i = zeros(set_vec)
    %constMat = zeros(const_vec)
    for idx_vec = set_vec
        for idx_const = const_vec
            piMat_i(idx_vec, five2one) = P_L_vec(idx_const);
        end
    end
    
end