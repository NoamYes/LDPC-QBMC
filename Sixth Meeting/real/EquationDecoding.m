function [Z] = EquationDecoding(eps, q, dc, dv)

size = log2(q) + 1; % M = size
Z = zeros(1, size);
Z(1) = 1 - eps;
Z(size) = eps;
iterLen = 100;
    for iter = 1:iterLen
        
        W = real_W_approx(q,dc,Z);
        W = W/sum(W); % nirmol since W gets values bigger than 1
        Z = real_Z_approx(q, dv, W, eps);
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end
        
    end
    
end

