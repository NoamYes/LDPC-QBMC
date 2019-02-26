function [Z] = EquationDecoding(e_vec, q, dc, dv, subsetsLen)

Z = [e_vec 0];
iterLen = 100;
    for iter = 1:iterLen

        W = w_approx(Z, q, dc, subsetsLen);
        Z = z_approx(W, q, dv, e_vec, subsetsLen);
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end

    end

end

