clc; clear all; close all;

%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested


n = 60; %n
k = round(n/2); %k
inc = 0.01; %how to increment the epsilon vector
inc1 = 0.01;
tryMat = 1; %how many matrixes to generate for a given epsilon
tryVec = 100; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be
q=4;

%  subsetTable = subset(q);
% looktable = look_up(q, subsetTable);
% dividetable = divide(q);
% intersectTable = intersect_lookup(subsetTable);

load('q=4_lookups.mat');
load('uniform_Pi_Ii_4.mat');

%% PI CAL

t = length(subsetTable);
% subsetsLen = cellfun('length', subsetTable);
% lenIdxsTable = cell(1,q);
% Pi_len_cell = cell(1,q);
% for len = 1:q
%     [~,lenIdxsTable{len}] = find(subsetsLen == len);
%     pi = zeros(1,t);
%     pi(lenIdxsTable{len}) = 1/numel(lenIdxsTable{len});
%     Pi_len_cell{len} = pi(lenIdxsTable{len});
% end




%%

e1_vec = 0.4:inc:0.4;
e2_vec = 0.2:inc:0.2;

% e1_vec = 

e_vec = [1/3 1/3 1/3];
dv = 4; 
dc = 8;
% L_vec = (1/(q-1))*ones(1,q-1);
L_vec = [1/2 1/2 0];
% PiMat = Pi(t, q, L_vec, dc, looktable, dividetable);
%[IiMat] = Ii(t, q, dv, intersectTable);
% [Z] = EquationDecoding(e_vec , PiMat, IiMat, t, q);
% [Z] = EquationDecoding2(e_vec , PiMat, Pi_len_cell, IiMat, t, q, dc, looktable, dividetable);

mean_mat = zeros([numel(e1_vec), numel(e2_vec)]);

tic;
for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    for jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        if e1 + e2 > 1
            mean_mat(idx,jdx) = 1;
        else
            e_vec = [(1-e1-e2) e1 e2];
            [Z, err_iter] = EquationDecoding3(e_vec , PiMat, IiMat, t, q);
            mean_mat(idx,jdx) = 1 - Z(1);
            
        end
    end
     disp(round(idx/numel(e1_vec)*100,1)+"% done in "+round(toc,1)+" (sec)");
end
figure(1)
plot(err_iter);
xlabel('Iteration');
ylabel('Erasure probabilty')
title('Erasure Probabilty versus iteration: \epsilon_1 = 0.4, \epsilon_2 = 0.2');
toc;