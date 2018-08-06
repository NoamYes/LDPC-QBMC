%[H,g,n,k] = hammgen(3);
H = [[1,0,0,1,1,1,0];[0,1,0,1,1,0,0];[0,0,1,1,0,1,1]];

QM = 2; %the question mark value > 0
iterLen = 100; %how many iterations for the matrix algo

vec = [0,QM,0,1,QM,QM,0];
 
checkNoise2(H, vec, iterLen, QM);
  