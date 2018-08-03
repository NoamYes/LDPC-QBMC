function [output] = checkHit(H,vec)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
output = 1;
if rand <= eps
    output = 0;
end

