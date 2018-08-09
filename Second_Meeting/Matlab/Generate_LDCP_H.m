function [ H ] = Generate_LDCP_H( dv, dc, m, n )
 %% dv - dimension of variables (1's num in columns)
 %% dc - dimension of checks (1's num in rows) 
 %% n,k arguments - size required for H
 if ( n-m < dc || n < dv)
     error('Wrong Parameters');
 end
 ns = round(n/dc);
 ms = round((n-m)/ns);
 H = zeros([n-m,n]);
 
 H1 = zeros(ns,ns*dc);
 H1(1,1:dc) = ones(1,dc);
 
 for i=2:ns
       H1(i,:) = circshift(H1(i-1,:),dc);
%      H(i,(i-1)*dc+1:i*dc) = ones(1,dc);
 end
 H = H1;
 for j=2:ms
    rows_perm_i = randperm(length(H));
%     H((j-1)*dv+1:j*dv,:) = H((j-2)*dv+1:(j-1)*dv,rows_perm_i);
    H_new = H1(:,rows_perm_i);
    H = [H; H_new];
 end

end

