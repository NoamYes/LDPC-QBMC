clc; clear all; close all;
[H,g,n,k] = hammgen(3);

QM = 2;
iterLen = 100;

oneQM = zeros(7,7);
twoQM = zeros(7,21);

for i = 1:7
    oneQM(i,i) = QM;
    checkNoise2(H,oneQM(:,i).' ,iterLen,QM);
end
   
for k = 1:6
    twoQM(1,k+0) = QM;
    twoQM(1+k,k+0) = QM;
end

for k = 1:5
    twoQM(2,k+6) = QM;
    twoQM(2+k,k+6) = QM;
end

for k = 1:4
    twoQM(3,k+11) = QM;
    twoQM(3+k,k+11) = QM;
end

for k = 1:3
    twoQM(4,k+15) = QM;
    twoQM(4+k,k+15) = QM;
end

for k = 1:2
    twoQM(5,k+18) = QM;
    twoQM(5+k,k+18) = QM;
end

for k = 1:1
    twoQM(6,k+20) = QM;
    twoQM(6+k,k+20) = QM;
end

for j = 1:21
    checkNoise2(H,twoQM(:,j).',iterLen,QM);
end