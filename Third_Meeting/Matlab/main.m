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


