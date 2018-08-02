%% This function gets an input and a chance of erased data epsilon
% and returns the input with the chance of an erasion
function [output] = BECnoise(input, epsilon)
questionMark = 2; % we can change this later

output = input;
if rand <= epsilon
    output = questionMark;
end
end