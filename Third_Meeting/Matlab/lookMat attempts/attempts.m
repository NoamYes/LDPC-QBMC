clear all; clc; close all;

%% nchoosek 

q = 16;
k = 8;
qCell = num2cell(0:q-1);
subsets = nchoosek(qCell, k); % return all subsets of values 0 to q-1 with size k