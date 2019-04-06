
q = 4;
diagonal = (0:q)/q;
tranMat = diag(diagonal);
tranMat(2:q+2:end)=1-(0:q-1)/q;
tranMat = tranMat.';

g_zero = zeros(1,q+1);
g_zero(1)=1;

array = [2,2,4,2,2];
N = prod(array,'all');
g_N = g_zero*(tranMat)^N;