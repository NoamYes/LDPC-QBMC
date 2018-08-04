%% This function get the vector length and a chance of erased data epsilon
% and returns a vector with the erasion
function [output] = BECnoise(n, epsilon, QM)

    tmp = rand(1,n) <= epsilon; %vector of logical 0 and 1 where there is an erasion
    output = tmp.*QM; %normalization

end