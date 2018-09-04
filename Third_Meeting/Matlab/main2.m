clc; clear all; close all;
tic
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested


n = 36; %n
k = round(n/2); %k
inc = 0.0025; %how to increment the epsilon vector
tryMat = 20; %how many matrixes to generate for a given epsilon
tryVec = 200; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be
q=4;
looktable = lookup(q);
dividetable = divide(q);

e1_vec = 0:inc:0.5;
e2_vec = 0:inc:0.5;
dv = 3; 
dc = 6;

H = cell(1,tryMat);
mean_mat = zeros([numel(e1_vec), numel(e2_vec)]);

for mat = 1:tryMat
    H{mat} = Generate_LDCP_H( dv, dc, k, n, q ); %generate a random H matrix
end

for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    parfor jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        totalNoise = zeros(tryVec, tryMat);
        for i = 1:tryMat %run on the number of matrixes
            for j = 1:tryVec %run on the number of vectors to
                vec = BECnoise(n, [e1, e2]); %generate a 0 vec with random noise
                totalNoise(j,i) = iter(H{i}, vec, iterLen, dc, looktable, dividetable); %save the
                %ratio of the noise after iterations to the total noise matrix
            end
    %         disp(round((i/tryMat+idx-1)*100/numel(eps_vec),1)+"% done in " + ...
    %             round(toc,1)+" (sec)");
        end
        mean_mat(idx,jdx) = mean(mean(totalNoise)); %calc the mean of all the noise
        % for a given epsilon
    end
end
figure(1)
RI = imref2d(size(mean_mat));
RI.XWorldLimits = [e1_vec(1) e1_vec(end)];
RI.YWorldLimits = [e2_vec(1) e2_vec(end)];
imshow(mean_mat, RI);
truesize([300 200]);
xlabel('one bits Erasure [{\epsilon1}]');
ylabel('two bits Erasure [{\epsilon2}]');
title('total erasure rate, q=4  ');

% figure(1)
% plot(eps_vec,mean_mat); hold on
% plot(eps_vec,eps_vec);
% title('Ratio of erasures after decoding with random noise VS erasure probablity');
% legend('Erasure','y=x')
% xlabel('Probablity Of Erasure [{\epsilon}]');
% ylabel('Erasure Rate');
% 
% dim = [.65 .15 .3 .15];
% str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
%     ", d_{c} = " + dc + ", d_{v} = " + dv;
% annotation('textbox',dim,'String',str,'FitBoxToText','on');

toc;