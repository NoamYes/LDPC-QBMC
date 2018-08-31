function [ set ] = sumset( mult, vec , lookup_mat)
%SUMSET Summary of this function goes here
%   Detailed explanation goes here

tmp = lookup_mat(mult(1)+1, vec(1)+1, mult(2)+1, vec(2)+1);
for i=3:length(vec)
    
%     set = lookup_mat(2, tmp, mult(i)+1, vec(i)+1);
        set = lookup_mat(1);

end

