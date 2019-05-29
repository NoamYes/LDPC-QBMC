function [tranMatUnion] = UnionTranMat(kapa,q)


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


end

