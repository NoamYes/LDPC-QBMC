clc; clear all; close all;
dbstop if error
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested

n = 60; %n
k = round(n/2); %k
inc = 0.02; %how to increment the epsilon vector
inc1 = 0.05;
inc2 = 0.02;
tryMat = 1; %how many matrixes to generate for a given epsilon
tryVec = 100; %how many noise vector to test each time
iterLen = 100; %how long will each code iteration be

dv = 3;
dc = 6;

q=4;

% subsetTable = subset(q);
% looktable = look_up(q, subsetTable);
% dividetable = divide(q);
% intersectTable = intersect_lookup(subsetTable);



% load('q=4_lookups.mat');

%% PI CAL
q=4;

IiMat = IiCalc(q, dv);

%% Balls and Bins
% PiMat = PiCalc(q, dc);

%% Union Model

PiMat = PiCalcUnion(q, dc);

%% uniform e vec


e1_vec = 0:inc:1;
e2_vec = 0:inc:1;

%% non uniform resolution
% thresh1 = 0.8;
% thresh2 = 0.4;

% e1_vec = [0:inc1:thresh1-0.1, thresh1-0.1:inc2: thresh1+0.1, thresh1+0.1:inc1:1 ];
% e2_vec = [0:inc1:thresh2-0.1, thresh2-0.1:inc2: thresh2+0.1, thresh2+0.1:inc1:1 ];

%% 

mean_mat = zeros([numel(e1_vec), numel(e2_vec)]);


tic;
for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    parfor jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        if e1 + e2 > 1
            mean_mat(idx,jdx) = 1;
        else
            e_vec = [(1-e1-e2) e1 e2];
            [Z] = EquationDecoding(e_vec, PiMat,  IiMat, q, dc, dv);
            mean_mat(idx,jdx) = 1 - Z(1);
        end
    end
    disp(round(idx/numel(e1_vec)*100,1)+"% done in "+round(toc,1)+" (sec)");
end
figure(1)
imshow(mean_mat.', 'XData', e2_vec, 'YData', e1_vec);
axis on;
view(-90,90)
truesize([300 200]);
xlabel('one bit Erasure [\epsilon_{1}]');
ylabel('two bits Erasure [\epsilon_{2}]');
str_title = "Union Model - Total erasure rate for q = " + q;
title(str_title);
% str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
%     ", d_{c} = " + dc + ", d_{v} = " + dv;

toc;