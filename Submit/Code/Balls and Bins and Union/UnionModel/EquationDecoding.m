function [Z] = EquationDecoding(eps_vec, PiMat, IiMat, q, dc, dv)

Z = eps_vec;
iterLen = 1000;
    for iter = 1:iterLen
%         tic
        W = w_comp(Z, PiMat, q, dc);
%         toc
%         tic
        Z = z_comp(W,IiMat, q, dv, eps_vec);
%         toc
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end
        
    end
    
end

