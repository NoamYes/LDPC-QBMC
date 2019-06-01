clc; clear all; close all;
dbstop if error
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested

n = 60; %n
k = round(n/2); %k
inc = 0.05; %how to increment the epsilon vector
inc1 = 0.4; %different resolution
inc2 = 0.01;
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

%% Union Model

PiMat = PiCalcUnion(q, dc);

%%


%% uniform resolution

e1_vec = 0:inc:1;
e2_vec = 0:inc:1;
e3_vec = 0:inc:1;

%% non uniform resolution
% thresh1 = 0.9;
% thresh2 = 0.7;
% thresh3 = 0.4;
%
% e1_vec = [0:inc1:thresh1-0.1, thresh1-0.1:inc2: thresh1+0.1, thresh1+0.1:inc1:1 ];
% e2_vec = [0:inc1:thresh2-0.1, thresh2-0.1:inc2: thresh2+0.1, thresh2+0.1:inc1:1 ];
% e3_vec = [0:inc1:thresh3-0.1, thresh3-0.1:inc2: thresh3+0.1, thresh3+0.1:inc1:1 ];
%
% e1_len = numel(e1_vec);
% e2_len = numel(e2_vec);
% e3_len = numel(e3_vec);

%% good resolution just on axis vectors!!!

res_len2 = numel(0:inc2:1);
e1_vec_axis = [0:inc2:1 zeros(1,res_len2) zeros(1,res_len2)];
e2_vec_axis = [zeros(1,res_len2) 0:inc2:1 zeros(1,res_len2)];
e3_vec_axis = [zeros(1,res_len2) zeros(1,res_len2) 0:inc2:1];



%% main decoding - all picture

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



%% empiric thresholds
e1_mat = find(mean_mat(:,1,1) == 0);
e2_mat = find(mean_mat(1,:,1) == 0);
e3_mat = find(mean_mat(1,1,:) == 0);

last_z_1 = e1_mat(end);
last_z_2 = e2_mat(end);
last_z_3 = e3_mat(end);

thresh1_emp = e1_vec(last_z_1);
thresh2_emp = e2_vec(last_z_2);
thresh3_emp = e3_vec(last_z_3);

%% plot graph

figure(1)
% imshow3D(mean_mat, 'XData', e2_vec, 'YData', e1_vec, 'ZData', e3_vec);
[xx, yy, zz] = meshgrid(e1_vec,e2_vec,e3_vec);
scatter3(xx(:),yy(:),zz(:), 50, mean_mat(:), 'filled')
hold on;
% axis on;
% view(-90,90)
% truesize([300 200]);
ylabel('one bit Erasure [\epsilon_{1}]');
xlabel('two bits Erasure [\epsilon_{2}]');
zlabel('three bits Erasure [\epsilon_{3}]');
str_title = "Total erasure rate for q = " + q + ...
    " Using Union Model";
title(str_title);
% % str = "n = " + n + ", mat# = " + tryMat + ", vec# = " + tryVec + ...
% %     ", d_{c} = " + dc + ", d_{v} = " + dv;



%% axises only

axis_res = zeros(size(e1_vec_axis));
axs_t = tic;
parfor tdx = 1:numel(e1_vec_axis)
    e1 = e1_vec_axis(tdx);
    e2 = e2_vec_axis(tdx);
    e3 = e3_vec_axis(tdx);    
    e_vec = [(1-e1-e2-e3) e1 e2 e3];
    [Z] = EquationDecoding(e_vec, PiMat,  IiMat, q, dc, dv);
    axis_res(tdx) = 1-Z(1);
%     scatter3(e1,e2,e3,50,1-Z(1),'filled');
%     hold on;
    disp(round(tdx/numel(e1_vec_axis)*100,1)+"% done in "+round(toc(axs_t),1)+" (sec)");
end

figure(1)
scatter3(e1_vec_axis,e2_vec_axis,e3_vec_axis,50,axis_res,'filled');