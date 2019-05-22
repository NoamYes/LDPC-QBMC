function [Z] = EquationDecoding(eps_vec, q, dc, dv)

Z = eps_vec;
iterLen = 100;
    for iter = 1:iterLen
        
        W = w_comp(Z, q, dc);
        Z = z_comp(W, q, dv, eps_vec);
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end
        
    end
    
end

