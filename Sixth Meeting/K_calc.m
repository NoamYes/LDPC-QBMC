function [K] = K_calc(mu,q, sizeArray)

n = (q-mu)*ones(1,length(sizeArray));
choose_array = arrayfun(@nchoosek,n,sizeArray-mu);
K = nchoosek(q,mu)*prod(choose_array);

end

