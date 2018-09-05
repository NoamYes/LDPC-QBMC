clc; clear all; close all;
tic
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested


n = 600; %n
k = round(n/2); %k
inc = 0.05; %how to increment the epsilon vector
tryMat = 1; %how many matrixes to generate for a given epsilon
tryVec = 100; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be
q=4;
looktable = lookup(q);
dividetable = divide(q);

e1_vec = 0:inc:1;
e2_vec = 0:inc:1;
dv = 3; 
dc = 6;

H = cell(1,tryMat);
mean_mat = zeros([numel(e1_vec), numel(e2_vec)]);

for mat = 1:tryMat
    H{mat} = Generate_LDCP_H( dv, dc, k, n, q ); %generate a random H matrix
end

for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    for jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        totalNoise = zeros(tryVec, tryMat);
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
        c2v_s.idxs  = sub2ind(size(H{i}), c2v_s.cols, c2v_s.rows);%% the function gets the Matrix and the QM as input and creates a vector of
%  var so the if there is a 0 in the row, it will be a 0 and if not, a QM.

            parfor j = 1:tryVec %run on the number of vectors to
                vec = BECnoise(n, [e1, e2]); %generate a 0 vec with random noise
%                 tic
                if e1 + e2 > 1
                    totalNoise(j,i) = 1;
                else
                totalNoise(j,i) = iter(H{i}, vec, iterLen, q, dc, v2c_s, c2v_s, looktable, dividetable); %save the
                %ratio of the noise after iterations to the total noise matrix
                end
%                 toc;
            end
    %         disp(round((i/tryMat+idx-1)*100/numel(eps_vec),1)+"% done in " + ...
    %             round(toc,1)+" (sec)");
        end
        mean_mat(idx,jdx) = mean(mean(totalNoise)); %calc the mean of all the noise
        % for a given epsilon
    end
    
    disp(round(idx*inc*100,1)+"% done in "+round(toc,1)+" (sec)");
   
end

figure(1)
imshow(mean_mat, 'XData', e1_vec, 'YData', e2_vec);
axis on;
view(-90,90)
truesize([300 200]);
xlabel('two bits Erasure [\epsilon_{2}]');
ylabel('one bits Erasure [\epsilon_{1}]');
str_title = "total erasure rate for q = " + q;
title(str_title);

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