function [ divide_mat ] = divide( q )
%DIVIDE Summary of this function goes here
%   Detailed explanation goes here
logq = log2(q);
divide_mat = zeros(q-1);

for i =1:q-1
    for j = 1:q-1
        tmp = gf(i,logq)/gf(j,logq);
        divide_mat(i,j) = tmp.x;
    end
end

end

