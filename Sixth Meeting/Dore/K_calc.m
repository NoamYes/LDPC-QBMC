function [K] = K_calc(q,M_d)
    mu = min(M_d);
    K = zers(1,log2(q)+1);
    for m = 0:numel(K)-1
        for s = 0:mu-m
            K(m) = K(m) + (-1)^s * v_ms_calc(m+s,q,M_d) * nchoosek(m+s, m);
        end
    end
end

function [v_ms] = v_ms_calc(ms, q, M_d)
    v_ms = nchoosek(q, ms);
    for size = M_d
        v_ms = v_ms * nchoosek(q - ms, size - ms);
    end
end

