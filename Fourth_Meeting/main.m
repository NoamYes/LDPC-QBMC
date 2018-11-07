clc; clear all; close all;

%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested


n = 60; %n
k = round(n/2); %k
inc = 0.05; %how to increment the epsilon vector
tryMat = 1; %how many matrixes to generate for a given epsilon
tryVec = 100; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be
q=4;

% subsetTable = subset(q);
% looktable = look_up(q, subsetTable);
% dividetable = divide(q);
% intersectTable = intersect_lookup(subsetTable);
load('q=8_lookups.mat');
t = length(subsetTable);

e1_vec = 0:inc:1;
e2_vec = 0:inc:1;
dv = 3; 
dc = 6;
L_vec = (1/3)*ones(1,3);
PiMat = Pi(t, q, L_vec, dc, looktable, dividetable);
[IiMat] = Ii(t, q, dv, intersectMat);

H = cell(1,tryMat);
mean_mat = zeros([numel(e1_vec), numel(e2_vec)]);

for mat_iter = 1:tryMat
    H{mat_iter} = Generate_LDCP_H( dv, dc, k, n, q ); %generate a random H matrix
end

tic
for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    parfor jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        if e1 + e2 > 1
            mean_mat(idx,jdx) = 1;
        else
            totalNoise = zeros(tryVec, tryMat);
            for mat_iter = 1:tryMat %run on the number of matrixes
                for vec_iter = 1:tryVec %run on the number of vectors to
                    vec = BECnoise(n, [e1, e2]); %generate a 0 vec with random noise
                    totalNoise(vec_iter,mat_iter) = iter(H{mat_iter}, vec, iterLen, dc, looktable, dividetable, q, intersectTable); %save the
                    %ratio of the noise after iterations to the total noise matrix
                end
            end
            mean_mat(idx,jdx) = mean(mean(totalNoise)); %calc the mean of all the noise
            % for a given epsilon
        end
    end
    disp(round(idx/numel(e1_vec)*100,1)+"% done in "+round(toc,1)+" (sec)");
end
figure(1)
imshow(mean_mat.', 'XData', e2_vec, 'YData', e1_vec);
axis on;
view(-90,90)
truesize([300 200]);
xlabel('one bits Erasure [\epsilon_{1}]');
ylabel('two bits Erasure [\epsilon_{2}]');
str_title = "total erasure rate for q = " + q;
title(str_title);
% str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
%     ", d_{c} = " + dc + ", d_{v} = " + dv;

toc;