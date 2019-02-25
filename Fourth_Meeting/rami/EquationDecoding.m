function [Z] = EquationDecoding(e_vec , size_distro, t, q, dc, dv, check, var)

Z = [e_vec zeros(1,t-log2(q)-1)];
iterLen = 100;
    for iter = 1:iterLen

        W = w_approx(Z, t, dc, size_distro, check);
        Z = z_approx(W, t, dv, size_distro, var, e_vec);
        Z = Z/sum(Z)
        if sum(Z == 1) > 0
            break;
        end

    end

end

