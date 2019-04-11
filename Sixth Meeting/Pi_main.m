clear all;

dbstop if error

q = 4;
diagonal = (0:q)/q;
tranMat = diag(diagonal);
tranMat(2:q+2:end)=1-(0:q-1)/q;
tranMat = tranMat.';
outDist = 1:log2(q)+1;
g_zero = zeros(1,q+1);
g_zero(1)=1;

array = [1,2,1,2,1];
N = prod(array,'all');
g_N = g_zero*(tranMat)^N;
indices = 1:numel(g_N);
powers = floor(log2((indices)))+1;

for i=1:log2(q)+1
   outDist(i) = sum(g_N(powers == i));   
end




% find(powers == outDist)
% outDist(powers) = g_N;
kapa = max(array);
% p = 2;
% BL_arg = min(p,sum(array)-length(array)-1);
% BL = max(kapa, BL_arg);

%% Union Model

K_calc(1, q, array);
tranMatUnion = ones(q+1);
for m = 1:q+1
    for mTag= 1:q+1
      prodChoose = nchoosek(q,m)*nchoosek(q,kapa);
      tranMatUnion(m,mTag) =  K_calc(m+kapa-mTag, q, array)/prodChoose; 
    end
end

