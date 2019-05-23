clc; clear all; close all;
dbstop if error
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

q=8;

% subsetTable = subset(q);
% looktable = look_up(q, subsetTable);
% dividetable = divide(q);
% intersectTable = intersect_lookup(subsetTable);



% load('q=4_lookups.mat');

%% PiMat and IiMat
IiMat = IiCalc(q, dv);
PiMat = PiCalc(q, dc);

%%


e1_vec = 0:inc:1;
e2_vec = 0:inc:1;
e3_vec = 0:inc:1;
e1_len = numel(e1_vec);
e2_len = numel(e2_vec);
e3_len = numel(e3_vec);

mean_mat = zeros([numel(e1_vec), numel(e2_vec), numel(e3_vec)]);


tic;
for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    for jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        parfor pdx = 1:numel(e3_vec)
            e3 = e3_vec(pdx);
            if e1 + e2 + e3> 1
                mean_mat(idx,jdx, pdx) = 1;
            else
                e_vec = [(1-e1-e2-e3) e1 e2 e3];
                [Z] = EquationDecoding(e_vec, PiMat,  IiMat, q, dc, dv);
                mean_mat(idx,jdx, pdx) = 1 - Z(1);
            end
        end
    end
    disp(round(idx/numel(e1_vec)*100,1)+"% done in "+round(toc,1)+" (sec)");
end

%% plot graph

figure(1)
% imshow3D(mean_mat, 'XData', e2_vec, 'YData', e1_vec, 'ZData', e3_vec);
[xx, yy, zz] = meshgrid(e1_vec,e2_vec,e3_vec);
scatter3(xx(:),yy(:),zz(:), 50, mean_mat(:), 'filled')
% axis on;
% view(-90,90)
% truesize([300 200]);
ylabel('one bit Erasure [\epsilon_{1}]');
xlabel('two bits Erasure [\epsilon_{2}]');
zlabel('three bits Erasure [\epsilon_{3}]');
% str_title = "total erasure rate for q = " + q;
% title(str_title);
% % str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
% %     ", d_{c} = " + dc + ", d_{v} = " + dv;

toc;