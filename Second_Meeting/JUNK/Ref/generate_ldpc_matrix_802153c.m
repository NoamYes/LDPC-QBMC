% Author : Miroslav Marinkovic
% E-mail : mmarinkovic78d@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the parity check matrix for code rate 1/2, 5/8, 3/4 and 7/8
% IEEE 802.15.3c standard


function [H_index] = generate_ldpc_matrix_802153c(n, code_rate)

if (n ~= 21)
  error('ldpc_matrix_802153c error: sub-matrix size is not supported');
end

% Each H_index matrix has 32 columns (from hc1 to hc32)
switch code_rate
  case 1/2
           % 1  2   3   4  5   6   7   8   9   10 11  12  13  14  15 16
    hc1 =  [-1; 0; -1; -1; 5; -1; -1; -1; -1; -1; 6; -1; -1; -1; -1; 18];    
    hc2 =  [-1; -1; -1; 18; -1; 0; -1; -1; 5; -1; -1; -1; -1; -1; 6; -1];    
    hc3 =  [-1; -1; 6; -1; -1; -1; -1; 18; -1; 0; -1; -1; 5; -1; -1; -1];    
    hc4 =  [5; -1; -1; -1; -1; -1; 6; -1; -1; -1; -1; 18; -1; 0; -1; -1];    
    hc5 =  [-1; -1; 7; -1; -1; -1; -1; 0; -1; 16; -1; -1; 18; -1; -1; -1];    
    hc6 =  [18; -1; -1; -1; -1; -1; 7; -1; -1; -1; -1; 0; -1; 16; -1; -1];    
    hc7 =  [-1; 16; -1; -1; 18; -1; -1; -1; -1; -1; 7; -1; -1; -1; -1; 0];    
    hc8 =  [-1; -1; -1; 0; -1; 16; -1; -1; 18; -1; -1; -1; -1; -1; 7; -1];    
    hc9 =  [-1; -1; -1; 10; -1; 6; -1; -1; 3; -1; -1; -1; -1; -1; 2; -1];    
    hc10 = [-1; -1; 2; -1; -1; -1; -1; 10; -1; 6; -1; -1; 3; -1; -1; -1];    
    hc11 = [3; -1; -1; -1; -1; -1; 2; -1; -1; -1; -1; 10; -1; 6; -1; -1];    
    hc12 = [-1; 6; -1; -1; 3; -1; -1; -1; -1; -1; 2; -1; -1; -1; -1; 10];    
    hc13 = [10; -1; -1; -1; -1; 0; -1; -1; -1; -1; 9; -1; -1; -1; -1; 16];    
    hc14 = [-1; -1; -1; 16; 10; -1; -1; -1; -1; 0; -1; -1; -1; -1; 9; -1];    
    hc15 = [-1; -1; 9; -1; -1; -1; -1; 16; 10; -1; -1; -1; -1; 0; -1; -1];    
    hc16 = [-1; 0; -1; -1; -1; -1; 9; -1; -1; -1; -1; 16; 10; -1; -1; -1];
    hc17 = [-1; -1; 20; -1; 5; -1; -1; -1; -1; -1; -1; 9; -1; 7; -1; -1];
    hc18 = [-1; 7; -1; -1; -1; -1; 20; -1; 5; -1; -1; -1; -1; -1; -1; 9];
    hc19 = [-1; -1; -1; 9; -1; 7; -1; -1; -1; -1; 20; -1; 5; -1; -1; -1];
    hc20 = [5; -1; -1; -1; -1; -1; -1; 9; -1; 7; -1; -1; -1; -1; 20; -1];
    hc21 = [-1; -1; -1; -1; -1; 4; -1; -1; 4; -1; -1; -1; -1; -1; -1; 12];
    hc22 = [-1; -1; -1; -1; -1; -1; 4; -1; -1; 4; -1; -1; -1; -1; -1; -1];
    hc23 = [-1; -1; -1; -1; -1; -1; -1; 12; -1; -1; 4; -1; -1; 4; -1; -1];
    hc24 = [-1; -1; -1; -1; 4; -1; -1; -1; -1; -1; -1; 12; -1; -1; 4; -1];
    hc25 = [-1; -1; -1; -1; 5; -1; -1; -1; -1; -1; -1; -1; -1; 10; -1; -1];
    hc26 = [-1; -1; -1; -1; -1; -1; -1; 4; -1; -1; -1; -1; -1; -1; 19; -1];
    hc27 = [-1; -1; -1; -1; -1; 10; -1; -1; -1; -1; -1; -1; 5; -1; -1; -1];
    hc28 = [-1; -1; -1; -1; -1; -1; 19; -1; -1; -1; -1; -1; -1; -1; -1; 4];
    hc29 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 7; -1; -1; -1];
    hc30 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 17];
    hc31 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 19; -1; -1];
    hc32 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 10; -1]; 
    
    H_index = cat(2, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12,...
      hc13, hc14, hc15, hc16, hc17, hc18, hc19, hc20, hc21, hc22, hc23,...
      hc24, hc25, hc26, hc27, hc28, hc29, hc30, hc31, hc32);
    
  case 5/8
          % 1  2   3   4  5   6   7   8   9  10  11  12
    hc1 =  [0; -1; -1; 5; -1; -1; -1; 6; -1; -1; -1; 18];    
    hc2 =  [-1; -1; 18; 0; -1; -1; 5; -1; -1; -1;  6; -1];    
    hc3 =  [-1; 6; -1; -1; -1; 18; 0; -1; -1; 5; -1; -1];    
    hc4 =  [ 5; -1; -1; -1;  6; -1; -1; -1; 18; 0; -1; -1];    
    hc5 =  [-1; 7; -1; -1; -1; 0; 16; -1; -1; 18; -1; -1];    
    hc6 =  [18; -1; -1; -1;  7; -1; -1; -1; 0; 16;  -1; -1];    
    hc7 =  [16; -1; -1; 18; -1; -1; -1;  7; -1; -1; -1; 0];    
    hc8 =  [-1; -1; 0; 16; -1; -1; 18; -1; -1; -1;  7; -1];    
    hc9 =  [-1; -1; 10; 6; -1; -1;  3; -1; -1; -1; 2; -1];    
    hc10 = [-1; 2; -1; -1; -1; 10; 6; -1; -1; 3; -1; -1];    
    hc11 = [3; -1; -1; -1; 2; -1; -1; -1; 10; 6; -1; -1];    
    hc12 = [6; -1; -1; 3; -1; -1; -1; 2; -1; -1; -1; 10];   
    hc13 = [10; -1; -1; 0; -1; -1; -1; 9; -1; -1; -1; 16]; 
    hc14 = [-1; -1; 16; 10; -1; -1; 0; -1; -1; -1; 9; -1];    
    hc15 = [-1; 9; -1; -1; -1; 16; 10; -1; -1; 0; -1; -1];    
    hc16 = [0; -1; -1; -1; 9; -1; -1; -1; 16; 10; -1; -1];
    hc17 = [-1; 20; -1; 5; -1; -1; -1; -1; 9; 7; -1; -1];
    hc18 = [7; -1; -1; -1; 20; -1; 5; -1; -1; -1; -1; 9];
    hc19 = [-1; -1; 9; 7; -1; -1; -1; 20; -1; 5; -1; -1];
    hc20 = [5; -1; -1; -1; -1; 9; 7; -1; -1; -1; 20; -1];
    hc21 = [-1; 4; -1; 4; -1; -1; 4; -1; -1; -1; -1; 12];
    hc22 = [-1; -1; 12; -1; 4; -1; 4; -1; -1; 4; -1; -1];
    hc23 = [4; -1; -1; -1; -1; 12; -1; 4; -1; 4; -1; -1];
    hc24 = [4; -1; -1; -1; -1; -1; -1; -1; 12; -1; 4; -1];
    hc25 = [-1; -1; 4; -1; -1; -1; -1; 19; -1; 10; -1; -1];
    hc26 = [10; -1; -1; -1; -1; -1; 5; -1; -1; -1; 19; -1];
    hc27 = [-1; 19; -1; -1; -1; -1; -1; -1; -1; 5; -1; -1];
    hc28 = [5; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 4];
    hc29 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; 7; -1; -1];
    hc30 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 17];
    hc31 = [-1; -1; 17; -1; -1; -1; -1; -1; -1; -1; -1; -1];
    hc32 = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 10; -1];
         
    H_index = cat(2, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12,...
      hc13, hc14, hc15, hc16, hc17, hc18, hc19, hc20, hc21, hc22, hc23,...
      hc24, hc25, hc26, hc27, hc28, hc29, hc30, hc31, hc32);   
    
  case 3/4
    
    hc1 =  [0; -1; 5; -1; -1; 6; -1; 18];    
    hc2 =  [-1; 18; 0; -1; 5; -1; -1; 6];    
    hc3 =  [-1; 6; -1; 18; 0; -1; 5; -1];    
    hc4 =  [5; -1; -1; 6; -1; 18; 0; -1];    
    hc5 =  [-1; 7; -1; 0; 16; -1; 18; -1];    
    hc6 =  [18; -1; -1; 7; -1; 0; 16; -1];    
    hc7 =  [16; -1; 18; -1; -1; 7; -1; 0];    
    hc8 =  [-1; 0; 16; -1; 18; -1; -1; 7];    
    hc9 =  [-1; 10; 6; -1; 3;  -1; -1; 2];    
    hc10 = [-1; 2; -1; 10; 6; -1; 3; -1];    
    hc11 = [3; -1; -1; 2; -1; 10; 6; -1];    
    hc12 = [6; -1; 3; -1; -1; 2; -1; 10];    
    hc13 = [10; -1; 0; -1; -1; 9; -1; 16];    
    hc14 = [-1; 16; 10; -1; 0; -1; -1; 9];    
    hc15 = [-1; 9; -1; 16; 10; -1; 0; -1];    
    hc16 = [0; -1; -1; 9; -1; 16; 10; -1];  
    hc17 = [-1; 20; 5; -1; -1; 9; 7; -1];  
    hc18 = [7; -1; -1; 20; 5; -1; -1; 9];  
    hc19 = [-1; 9; 7; -1; -1; 20; 5; -1];  
    hc20 = [5; -1; -1; 9; 7; -1; -1; 20;];  
    hc21 = [-1; 4; 4; -1; 4; -1; -1; 12];  
    hc22 = [-1; 12; -1; 4; 4; -1; 4; -1];  
    hc23 = [4; -1; -1; 12; -1; 4; 4; -1];  
    hc24 = [4; -1; 4; -1; -1; 12; -1; 4];  
    hc25 = [-1; 4; 5; -1; -1; 19; 10; -1]; 
    hc26 = [10; -1; -1; 4; 5; -1; -1; 19];  
    hc27 = [-1; 19; 10; -1; -1; -1; 5; -1]; 
    hc28 = [5; -1; -1; 19; -1; -1; -1; 4]; 
    hc29 = [-1; -1; 19; -1; -1; -1; 7; -1]; 
    hc30 = [-1; -1; -1; 10; -1; -1; -1; 17]; 
    hc31 = [-1; -1; -1; -1; -1; -1; 19; -1]; 
    hc32 = [-1; -1; -1; -1; -1; -1; -1; 10]; 
        
    H_index = cat(2, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12,...
      hc13, hc14, hc15, hc16, hc17, hc18, hc19, hc20, hc21, hc22, hc23,...
      hc24, hc25, hc26, hc27, hc28, hc29, hc30, hc31, hc32);
    
  case 7/8
    
    hc1 = [0; 5; 6; 18];    
    hc2 = [18; 0; 5; 6];    
    hc3 = [6; 18; 0; 5];    
    hc4 = [5; 6; 18; 0];    
    hc5 = [7; 0; 16; 18];    
    hc6 = [18; 7; 0; 16];    
    hc7 = [16; 18; 7; 0];    
    hc8 = [0; 16; 18; 7];    
    hc9 = [10; 6; 3; 2];    
    hc10 = [2; 10; 6; 3];    
    hc11 = [3; 2; 10; 6];    
    hc12 = [6; 3; 2; 10];    
    hc13 = [10; 0; 9; 16];    
    hc14 = [16; 10; 0; 9];    
    hc15 = [9; 16; 10; 0];    
    hc16 = [0; 9; 16; 10];
    hc17 = [20; 5; 9; 7];
    hc18 = [7; 20; 5; 9];
    hc19 = [9; 7; 20; 5];
    hc20 = [5; 9; 7; 20];
    hc21 = [4; 4; 4; 12];
    hc22 = [12; 4; 4; 4];
    hc23 = [4; 12; 4; 4];
    hc24 = [4; 4; 12; 4];
    hc25 = [4; 5; 19; 10];
    hc26 = [10; 4; 5; 19];
    hc27 = [19; 10; 4; 5];
    hc28 = [5; 19; 10; 4];
    hc29 = [10; 19; 17; 7];
    hc30 = [-1; 10; 19; 17];
    hc31 = [-1; -1; 10; 19];
    hc32 = [-1; -1; -1; 10];
            
    H_index = cat(2, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12,...
      hc13, hc14, hc15, hc16, hc17, hc18, hc19, hc20, hc21, hc22, hc23,...
      hc24, hc25, hc26, hc27, hc28, hc29, hc30, hc31, hc32);
    
  otherwise
    error('ldpc_matrix_802153c error: code rate is not supported');
end

end
