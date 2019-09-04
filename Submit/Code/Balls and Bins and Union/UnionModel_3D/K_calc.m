% function [Km] = K_calc(q, sizeArray)
% 
% mu = min(sizeArray);
% Km = zeros(1,mu);
% for m = 1:mu
%    for s = 1:mu-m
%        Km(m) = Km(m) + (-1)^(s-1)*v_calc(q, m+s-1, sizeArray)*nchoosek(m+s-1,m);
%    end
% end

% end

function [K] = K_calc(q,M_d,mu)
    K = zeros(1,q+1);
    for m = 0:numel(K)-1
        for s = 0:mu-m
            K(m+1) = K(m+1) + (-1)^s * v_ms_calc(m+s,q,M_d) * nchoosek(m+s, m);
        end
    end
end

% function [v] = v_calc(q,m_s, sizeArray)
% 
% mu = min(sizeArray);
% n = (q-mu)*ones(1,length(sizeArray));
% array_t = sizeArray-mu;
% arrayFun = arrayfun(@nchoosek,n, array_t);
% v = nchoosek(q,m_s)*prod(arrayFun);
% 
% 
% end

function [v_ms] = v_ms_calc(ms, q, M_d)
    v_ms = nchoosek(q, ms);
    for size = M_d
        v_ms = v_ms * nchoosek(q - ms, size - ms);
    end
end

