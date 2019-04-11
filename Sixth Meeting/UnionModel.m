function [Pi] = UnionModel(q,sizeArray)

%BAB Balls and Bins
%input - q, dc-1 sizes of subgroups
%output - size distribution of log2q+1 sizes at the output - Pi(Hm)

diagonal = (0:q)/q;
tranMat = diag(diagonal);
tranMat(2:q+2:end)=1-(0:q-1)/q;
tranMat = tranMat.';
Pi =  1:log2(q)+1;
g_zero = zeros(1,q+1);
g_zero(1)=1;

N = prod(sizeArray,'all');
g_N = g_zero*(tranMat)^N;

indices = 1:numel(g_N);
powers = floor(log2((indices)))+1;

for i=1:log2(q)+1
   Pi(i) = sum(g_N(powers == i));   
end

end

