function [Z] = EquationDecoding(eps_vec, PiMat, IiMat, q, dc, dv)

Z = eps_vec;
iterLen = 100;
    for iter = 1:iterLen
        
        W = w_comp(Z, PiMat, q, dc);
        Z = z_comp(W,IiMat, q, dv, eps_vec);
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end
        
    end
    
end

