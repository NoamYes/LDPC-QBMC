clc; clear all; close all;
tic
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested

n = 1002; %n
k = round(n/2); %k
QM = 2; %the question mark value > 0
inc = 0.05;
tryMat = 100; %how many matrixes to generate for a given epsilon
tryVec = 100;
iterLen = 100;

eps_vec = 0.3:inc:0.6;
dv = 3; 
dc = 6;

H = zeros([n-k, n, tryMat]);
mean_vec = zeros([1, length(eps_vec)]);

parfor mat = 1:tryMat
    H(:,:,mat) = Generate_LDCP_H( dv, dc, k, n ); %generate a random H matrix
end

parfor idx = 1:numel(eps_vec) %run on epsilon values from 0 to 1 in increments of inc
    eps = eps_vec(idx);
    totalNoise = zeros(tryVec, tryMat);
    mean_mat = zeros(1, tryMat);
    for i = 1:tryMat
        for j = 1:tryVec
            vec = BECnoise(n, eps, QM); %generate a 0 vec with random noise
            totalNoise(j,i) = iter(H(:,:,i), vec, QM, iterLen);
        end
%         disp(round((i/tryMat+idx-1)*100/numel(eps_vec),1)+"% done in " + ...
%             round(toc,1)+" (sec)");
    end
    mean_vec(idx) = mean(mean(totalNoise));
end

figure(1)
plot(eps_vec,mean_vec); hold on
plot(eps_vec,eps_vec);
title('Ratio of erasures after decoding with random noise VS erasure probablity');
legend('Erasure','y=x')
xlabel('Probablity Of Erasure [{\epsilon}]');
ylabel('Erasure Rate');

dim = [.65 .15 .3 .15];
str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
    ", d_{c} = " + dc + ", d_{v} = " + dv;
annotation('textbox',dim,'String',str,'FitBoxToText','on');

toc;