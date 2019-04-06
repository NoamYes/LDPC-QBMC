function [Pi] = BallsandBins(q,sizeArray)

%BAB Balls and Bins
%input - q, dc-1 sizes of subgroups
%output - size distribution of log2q+1 sizes at the output - Pi(Hm)

diagonal = (0:q)/q;
tranMat = diag(diagonal);
tranMat(2:q+2:end)=1-(0:q-1)/q;
tranMat = tranMat.';

g_zero = zeros(1,q+1);
g_zero(1)=1;

N = prod(sizeArray,'all');
g_N = g_zero*(tranMat)^N;


end

