function [lookMat] = lookup(q) %lookup(i,j+1,k,h+1)
    logq = log2(q);
    lookMat = zeros(q-1, logq, q-1, logq);
    for i = 1:q-1
        for j = 0:logq
            for k = 1:q-1
                for h = 0:logq
                    a = [];
                    for m = 0:2^j-1
                        for n = 0:2^h-1
                            a = [a, gf(i, logq) * gf(m, logq) + gf(k, logq) * gf(n, logq)];
                        end
                    end
                    lookMat(i,j+1,k,h+1) = numel(unique(a.x)) - 1;
                end
            end
        end
    end              
end

