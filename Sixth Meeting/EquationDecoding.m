function [Z] = EquationDecoding(e_vec, q, dc, dv, PiMat)

Z = e_vec;
iterLen = 100;
    for iter = 1:iterLen

        W = w_approx(Z, q, dc, PiMat);
        Z = z_approx(W, q, dv, e_vec);
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end
        
    end
    
end

