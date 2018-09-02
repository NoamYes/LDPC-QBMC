function [ set ] = sumset( mult, vec , iter, lookMat, divideMat)
%SUMSET Summary of this function goes here
%   Detailed explanation goes here
% logq = size(lookMat,2)-1;

divider = mult(iter);
multH = divideMat(mult, divider);
tmp = lookMat(multH(1), log2(vec(1)+1)+1, multH(2), log2(vec(2)+1)+1);

for i=3:length(vec)
    
    set = lookMat(1, log2(tmp+1)+1, multH(i), log2(vec(i)+1)+1);

end

end


