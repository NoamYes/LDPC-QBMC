clc; clear all; close all;
tic
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested

n = 2004; %n
k = round(n/2); %k
QM = 2; %the question mark value > 0
inc = 0.005; %how to increment the epsilon vector
tryMat = 100; %how many matrixes to generate for a given epsilon
tryVec = 200; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be

eps_vec = 0.35:inc:0.45;
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
    for i = 1:tryMat %run on the number of matrixes
        for j = 1:tryVec %run on the number of vectors to
            vec = BECnoise(n, eps, QM); %generate a 0 vec with random noise
            totalNoise(j,i) = iter(H(:,:,i), vec, QM, iterLen); %save the
            %ratio of the noise after iterations to the total noise matrix
        end
%         disp(round((i/tryMat+idx-1)*100/numel(eps_vec),1)+"% done in " + ...
%             round(toc,1)+" (sec)");
    end
    mean_vec(idx) = mean(mean(totalNoise)); %calc the mean of all the noise
    % for a given epsilon
    tic;
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