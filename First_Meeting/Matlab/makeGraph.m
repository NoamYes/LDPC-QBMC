clc; clear all; close all;

% for n = 1000:1000:10000
    n = 1000; %n
    k = round(n/2); %k
    QM = 2; %the question mark value > 0
    iterLen = 100; %how many iterations for the matrix algo
    inc = 0.05; %how much to increment epsilon
    tryNum = 1000; %how many matrixes to generate for a given epsilon

    eps_vec = 0:inc:1;
    noise_vec = zeros(1,length(eps_vec));
    count = 1;
    H = generateH(n,k); %generate a random H matrix
    for eps = eps_vec %run on epsilon values from 0 to 1 in increments of inc
        totalNoise = zeros(1, tryNum);
        for i = 1:tryNum
            vec = BECnoise(n, eps, QM); %generate a 0 vec with random noise
            totalNoise(i) = checkNoise(H, vec, iterLen, QM);
        end
        noise_vec(count) = mean(totalNoise);
        count = count + 1;
     end

    figure(1)
    plot(eps_vec,noise_vec); hold on
    plot(eps_vec,eps_vec);
    title('ratio of erasures after decoding with random noise VS erasure probablity');
    legend('Erasure','y=x')
    xlabel('Probablity Of Erasure [{\epsilon}]');
    ylabel('Erasure Rate');
% end