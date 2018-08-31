m = 1; % Or choose any positive integer value of m.
alph = gf([0 1],m) % Primitive element in GF(2^m)

sum1 = @(x,y) x+y;
mat = ones(3);
sum1(mat);