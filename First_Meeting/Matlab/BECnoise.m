%% This function get the vector length and a chance of erased data epsilon
% and returns a vector with the erasion
function [output] = BECnoise(n, epsilon)
questionMark = 2; % we can change this later

tmp = rand(1,n) <= epsilon; %vector of logical 0 and 1 where there is an erasion
output = tmp.*questionMark; %normalization

end