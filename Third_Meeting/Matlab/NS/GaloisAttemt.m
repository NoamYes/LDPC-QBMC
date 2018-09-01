m = 1; % Or choose any positive integer value of m.
alph = gf([0 1],m) % Primitive element in GF(2^m)


A = [1 1; 1 1; 1 1];
B = [2 3; 4 4; 5 5];

sum_set = @(i,j) sumset(A(i,:),B(j,:));
n = size(A,1);
% C = arrayfun(sum_set, 1:n, 1:n);

tic
3/4
toc;
tic
gf(3,3)/gf(4,3)
toc;
