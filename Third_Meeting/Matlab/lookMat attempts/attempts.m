clear all; clc; close all;

%% nchoosek 

q = 16;
k = 8;
qCell = num2cell(0:q-1);
subsets = nchoosek(qCell, k); % return all subsets of values 0 to q-1 with size k


%% size of t

t=0;
s= log2(q);
for c = 0:s
    syms b
    nom = symprod(2^s-2^(b-1), b, 1, c);
    denom = symprod(2^c-2^(b-1), b, 1, c);
    t = t + double(nom)/double(denom);
end

matSize = t^2*(q-1)^2;