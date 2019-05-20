function [Q_ret] = Q_calc(q,M_d)
    mu = min(M_d);
    Q = zeros(1,q);
    if mu > 1
        for m = 1:numel(Q) % we start from 2 since K_0 is zero (not defined)
            K_m = K_calc(q-1,M_d-1,mu-1);
            Q(m) = K_m(m);
            for m_tag = M_d
                Q(m) = Q(m) / nchoosek(q-1,m_tag-1);
            end
        end
    else
        Q(1) = 1; 
    end
    Q_ret = zeros(1,log2(q)+1);
    powers = 2.^(0:log2(q));
    Q_ret = Q(powers);
end

function [K] = K_calc(q,M_d,mu)
    K = zeros(1,q+1);
    for m = 0:numel(K)-1
        for s = 0:mu-m
            K(m+1) = K(m+1) + (-1)^s * v_ms_calc(m+s,q,M_d) * nchoosek(m+s, m);
        end
    end
end

function [v_ms] = v_ms_calc(ms, q, M_d)
    v_ms = nchoosek(q, ms);
    for size = M_d
        v_ms = v_ms * nchoosek(q - ms, size - ms);
    end
end

