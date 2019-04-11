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

dv = 3; 
dc = 6;


% subsetTable = subset(q);
% looktable = look_up(q, subsetTable);
% dividetable = divide(q);
% intersectTable = intersect_lookup(subsetTable);


%% size distribution
q = [4, 8, 16, 32, 64];
entropDist = q;
sizeDistCell = cell(1,length(q));
sizeDistPercCell = cell(1,length(q));
for i = 1:length(q)
    [sizeDist,sizeDistPerc] = sizeDistribution(dc,q(i)); %% analytic solution to size distribution
    entropDist(i) = entropy(sizeDistPerc); %% vector of entropies - seemingly low entropy wanted
    sizeDistCell{i} = sizeDist; % Size distribution at integers
    sizeDistPercCell{i} = sizeDistPerc; % size percentage distribution
end
% [sizeDist,sizeDistPerc] = sizeDistribution(dc,q);
% sizeDist2 = checkCalc2(q, dc);

load('q=4_lookups.mat');

%% PI CAL
q=4;

t = length(subsetTable);
subsetsLen = cellfun('length', subsetTable);
size_distribution = zeros(q,t);
for len = 1:q
    [~, idx] = find(len >= subsetsLen);
    size_distribution(len,idx) = 1/numel(idx); % assume uniform dist.
end


%%

e1_vec = 0:inc:1;
e2_vec = 0:inc:1;


%%
check = checkCalc(t, q, dc, subsetsLen);
var = varCalc(t, q, dv, subsetsLen);

checkDist = zeros(1,t);
for i = 1:q
    [~, idx] = find(subsetsLen <= i);
    checkDist(idx) = checkDist(idx) + check(i)*size_distribution(i, idx);
end

mean_mat = zeros([numel(e1_vec), numel(e2_vec)]);
pi = sizeDistPercCell{1};
tic;
for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    for jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        if e1 + e2 > 1
            mean_mat(idx,jdx) = 1;
        else
            e_vec = [(1-e1-e2) e1 e2];
            [Z] = EquationDecoding(e_vec, q, dc, dv, pi);
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
str_title = "total erasure rate for q = " + q;
title(str_title);
% str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
%     ", d_{c} = " + dc + ", d_{v} = " + dv;

toc;