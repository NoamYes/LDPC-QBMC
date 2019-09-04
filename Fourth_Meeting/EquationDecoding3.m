function [Z, err_iter] = EquationDecoding(e_vec , Pi, Ii, t, q)

Z = [e_vec zeros(1,t-log2(q)-1)];
err_iter = [];
iterLen = 100;
% Z = zeros(1,t);
% Z(1:length(e_vec)) = e_vec;
    for iter = 1:iterLen

        W = w_comp(Z, Pi);
        Z = z_comp(W, Ii, e_vec);
        Z = Z/sum(Z);
        if sum(Z == 1) > 0
            break;
        end
        err_iter = [err_iter 1-Z(1)];

    end

end

