H =  [1, 1, 0, 1, 1, 0, 0; 
1, 0, 1, 1, 0, 1, 0; 
0, 1, 1, 1, 0, 0, 1]; 

QM =2;
noised = [ 0 QM QM 1 0 QM 0];
decoded = Iter_Method(H, noised, QM);