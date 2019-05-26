clear all;

dbstop if error

q = 4;
dc = 6;
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



%% Union Model
array = [1,1,2,1,2];
N = prod(array);
kapa = 4;
tranMatUnion = zeros(q+1);

for m = 0:q
    for mTag= m:m+kapa
        prodChoose = nchoosek(q,m)*nchoosek(q,kapa);
        n = m+kapa-mTag;
        M_d = [m, kapa];
        mu = min(M_d);
        K_tmp = K_calc(q, M_d, mu)/prodChoose;
        if m+kapa-mTag+1 > length(K_tmp)
            tranMatUnion(m+1,mTag+1) = 0;
        elseif mTag+1<q+2
            tranMatUnion(m+1,mTag+1) = K_tmp(m+kapa-mTag+1);
        end
    end
end



