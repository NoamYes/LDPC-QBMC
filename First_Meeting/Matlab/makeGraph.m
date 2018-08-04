n = 70;
k = 40;
QM = 2; %the question mark value > 0
iterLen = n; %how many iterations for the matrix algo
inc = 0.05; %how much to increment epsilon
tryNum = 1000; %how many matrixes to generate for a given epsilon
eps_vec = 0:inc:1;
hit_vec = zeros(1,length(eps_vec));
count = 1;
H = generateH(n,k); %generate a random H matrix
for eps = eps_vec %run on epsilon values from 0 to 1 in increments of inc
    totalHit = 0;
    for i = 1:tryNum
        vec = BECnoise(n, eps, QM); %generate a 0 vec with random noise
        totalHit = totalHit + checkHit(H,vec,iterLen,QM);
    end
    hit_vec(count) = totalHit/tryNum;
    count = count + 1;
end

figure(1)
plot(eps_vec,hit_vec);
title('ratio of erasures after decoding with random noise VS erasure probablity');
xlabel('Probablity Of Erasure');
ylabel('Erasure Rate');