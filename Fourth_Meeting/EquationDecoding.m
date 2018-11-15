function [Z] = EquationDecoding(e_vec , Pi, Ii, t, q)

Z = [e_vec zeros(1,t-q-1)];
iterLen = 100;
% Z = zeros(1,t);
% Z(1:length(e_vec)) = e_vec;
for iter = 1:iterLen
    
    W = w_comp(Z, Pi);
    Z = z_comp(W, Ii, t, q, e_vec);

end

