clc; clear all; close all;
tic
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested
dbstop if error

n = 4008; %n
k = round(n/2); %k
QM = 2; %the question mark value > 0
inc = 0.005; %how to increment the epsilon vector
tryMat = 1; %how many matrixes to generate for a given epsilon
tryVec = 20; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be
q=4;

eps_vec = [0.1 0.2];
dv = 3; 
dc = 6;

H = cell(1,tryMat);
mean_vec = zeros([1, length(eps_vec)]);

for mat = 1:tryMat
    H{mat} = Generate_LDCP_H( dv, dc, k, n, q ); %generate a random H matrix
end

[lookMat] = lookup(q);
divideMat = divide(q);

for idx = 1:numel(eps_vec) %run on epsilon values from 0 to 1 in increments of inc
    eps = eps_vec(idx);
    totalNoise = zeros(tryVec, tryMat);
    mean_mat = zeros(1, tryMat);
    for i = 1:tryMat %run on the number of matrixes
        
        [non_zeros1] = find(H{i});
        [rv,cv,v] = find(H{i});
        v2c_s.idxs = vec2mat(non_zeros1,dv);%reshape(non_zeros1,n,dv);
        v2c_s.vals = vec2mat(v,dv);%reshape(v,n,dv);
        v2c_s.rows = vec2mat(rv,dv);%reshape(rv,n,dv);
        v2c_s.cols = vec2mat(cv,dv);%reshape(cv,n,dv);

        [non_zeros2] = find(H{i});
        [rc,cc,c] = find(H{i}.');
        c2v_s.idxs = vec2mat(non_zeros2,dc);%reshape(non_zeros2,n-k,dc);
        c2v_s.vals = vec2mat(c,dc);%reshape(c,n-k,dc);
        c2v_s.rows = vec2mat(rc,dc);%reshape(rc.',n-k,dc);
        c2v_s.cols = vec2mat(cc,dc);%reshape(cc,n-k,dc);
        c2v_s.idxs  = sub2ind(size(H{i}), c2v_s.cols, c2v_s.rows);

        parfor j = 1:tryVec %run on the number of vectors to
            vec = BECnoise(n, eps); %generate a 0 vec with random noise
%             tic
            totalNoise(j,i) = iter(H{i}, vec, q, iterLen, dc, v2c_s, c2v_s, lookMat, divideMat); %save the
            %ratio of the noise after iterations to the total noise matrix
%             toc;
        end
%         disp(round((i/tryMat+idx-1)*100/numel(eps_vec),1)+"% done in " + ...
%             round(toc,1)+" (sec)");
    end
    mean_vec(idx) = mean(mean(totalNoise)); %calc the mean of all the noise
    % for a given epsilon
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