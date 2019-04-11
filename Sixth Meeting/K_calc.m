function [K] = K_calc(mu,q, sizeArray)

n = (q-mu)*ones(1,length(sizeArray));
array_t = sizeArray-mu;
array_t(array_t < 0) = 0;
n(n<0) = 0; 
choose_array = arrayfun(@nchoosek,n,array_t);
K = nchoosek(q,mu)*prod(choose_array);

end

