%% the function gets a vector with QM in it, and returns the same one
% but with 0's instead of QM
function [out_vec] = QM2null(vec, QM)

vec(vec == QM) = 0;
out_vec = vec;

end

