n = 6;
k = 4;
inc = 0.05; %how much to increment epsilon
tryNum = 100; %how many matrixes to generate for a given epsilon
eps_vec = 0:inc:1;
hit_vec = zeros(1,length(eps_vec));
count = 1;
for eps = eps_vec %run on epsilon values from 0 to 1 in increments of inc
    totalHit = 0;
    for i = 1:tryNum
        H = generateH(n,k);
        totalHit = totalHit + checkHit(H,n,k,eps);
    end
    hit_vec(count) = totalHit/tryNum;
    count = count + 1;
end

figure(1)
plot(eps_vec,hit_vec);