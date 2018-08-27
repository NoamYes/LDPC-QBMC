function [ H ] = Generate_LDCP_H( dv, dc, m, n, q )
%% dv - dimension of variables (1's num in columns)
%% dc - dimension of checks (1's num in rows)
%% n,m arguments - size required for H
    if ( n-m < dc || n < dv)
        error('Wrong Parameters');
    end
    ns = floor(n/dc);
    ms = floor((n-m)/ns);
    
    H1 = zeros(ns,ns*dc);
    H1(1,1:dc) = ones(1,dc);

    for i=2:ns
        H1(i,:) = circshift(H1(i-1,:),[0 dc]);
    end
    H = H1;
    for j=2:ms
        rows_perm_i = randperm(length(H));
        H_new = H1(:,rows_perm_i);
        H = [H; H_new];
    end
    options = gf(0:q-1,log2(q));
    perm = randi(q, size(H));
    randH = options(perm);
    H = H.*randH;
end

