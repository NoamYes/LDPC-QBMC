clc; clear all; close all;
tic
%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested

n=36;
k = round(n/2); %k
QM = 2; %the question mark value > 0
dv = 3; 
dc = 6;

q = 4;


H = Generate_LDCP_H( dv, dc, k, n, q ); %generate a random H matrix

[non_zeros1] = find(H);
[rv,cv,v] = find(H);
v2c_s.idxs = reshape(non_zeros1,n-k,dc);
v2c_s.vals = reshape(v,n-k,dc);
v2c_s.rows = reshape(rv,n-k,dc);
v2c_s.cols = reshape(cv,n-k,dc);

[non_zeros2] = find(H');
[rc,cc,c] = find(H');
c2v_s.idxs = reshape(non_zeros2,n,dv);
c2v_s.vals = reshape(c,n,dv);
c2v_s.rows = reshape(rc,n,dv);
c2v_s.cols = reshape(cc,n,dv);


% v2c_cell = mat2cell(H,ones(1,size(H,1)),size(H,2));
% v2c_reduced = cellfun(@find, v2c_cell,'UniformOutput', false);
% v2c_f = cell2mat(v2c_reduced);
% 
% H_t = H.';
% c2v_cell = mat2cell(H_t,ones(1,size(H_t,1)),size(H_t,2));
% c2v_reduced = cellfun(@find, c2v_cell,'UniformOutput', false);
% c2v_f = cell2mat(c2v_reduced);


