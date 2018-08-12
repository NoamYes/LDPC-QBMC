% Author : Miroslav Marinkovic
% E-mail : mmarinkovic78d@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the parity check matrix for code rate 1/2, 2/3 and 3/4
% IEEE 802.16e standard (WiMAX)

function [H_index] = generate_ldpc_matrix_80216e(n, code_rate)

% Each H_index matrix has 24 columns (from hc1 to hc24)
% row permutation of H_index
% dimension of sub-matrix n x n;

% 19 modes for LDPC code, code rate = 1/2;

% Mode

% 1.  n =24, LDPC(576,288)
% 2.  n =28, LDPC(672,336)
% 3.  n =32, LDPC(768,384)
% 4.  n =36, LDPC(864,432)
% 5.  n =40, LDPC(960,480)
% 6.  n =44, LDPC(1056,528)
% 7.  n =48, LDPC(1152,576)
% 8.  n =52, LDPC(1248,624)
% 9.  n =56, LDPC(1344,672)
% 10. n =60, LDPC(1440,720)
% 11. n =64, LDPC(1536,768)
% 12. n =68, LDPC(1632,816)
% 13. n =72, LDPC(1728,864)
% 14. n =76, LDPC(1824,912)
% 15. n =80, LDPC(1920,960)
% 16. n =84, LDPC(2016,1008)
% 17. n =88, LDPC(2112,1056)
% 18. n =92, LDPC(2208,1104)
% 19. n =96, LDPC(2304,1152)

% 19 modes for LDPC code, code rate = 2/3B;

% Mode

% 1.  n =24, LDPC(576,384)
% 2.  n =28, LDPC(672,448)
% 3.  n =32, LDPC(768,512)
% 4.  n =36, LDPC(864,432)
% 5.  n =40, LDPC(960,576)
% 6.  n =44, LDPC(1056,704)
% 7.  n =48, LDPC(1152,768)
% 8.  n =52, LDPC(1248,832)
% 9.  n =56, LDPC(1344,896)
% 10. n =60, LDPC(1440,960)
% 11. n =64, LDPC(1536,1024)
% 12. n =68, LDPC(1632,1088)
% 13. n =72, LDPC(1728,1152)
% 14. n =76, LDPC(1824,1216)
% 15. n =80, LDPC(1920,1280)
% 16. n =84, LDPC(2016,1344)
% 17. n =88, LDPC(2112,1408)
% 18. n =92, LDPC(2208,1472)
% 19. n =96, LDPC(2304,1536)

if (mod(n,4) ~= 0 || n < 24 || n > 96)
  error('ldpc_matrix_80216e error: sub-matrix size is not supported');
end

k = 96;

switch code_rate
  
  case 1/2
    hc1 =  [-1;-1;-1;floor(61*n/k);-1;-1;-1;-1;floor(12*n/k);-1;-1;floor(43*n/k)];
    hc2 =  [floor(94*n/k);floor(27*n/k);-1;-1;-1;-1;-1;floor(11*n/k);-1;-1;-1;-1];
    hc3 =  [floor(73*n/k);-1;-1;floor(47*n/k);floor(39*n/k);-1;floor(95*n/k);floor(73*n/k);-1;-1;floor(7*n/k);-1];
    hc4 =  [-1;-1;floor(24*n/k);-1;-1;-1;floor(53*n/k);-1;-1;-1;floor(65*n/k);-1];
    hc5 =  [-1;-1;floor(22*n/k);-1;-1;floor(46*n/k);-1;-1;floor(83*n/k);-1;-1;-1];
    hc6 =  [-1;floor(22*n/k);floor(81*n/k);-1;-1;floor(40*n/k);-1;-1;floor(24*n/k);floor(94*n/k);-1;floor(66*n/k)];
    hc7 =  [-1;floor(79*n/k);-1;-1;floor(84*n/k);-1;-1;floor(2*n/k);-1;-1;-1;-1];
    hc8 =  [-1;floor(9*n/k);floor(33*n/k);-1;-1;floor(82*n/k);-1;-1;floor(43*n/k);floor(59*n/k);-1;floor(41*n/k)];
    hc9 =  [floor(55*n/k);-1;-1;floor(65*n/k);-1;-1;-1;-1;-1;-1;floor(39*n/k);-1];
    hc10 = [floor(83*n/k);-1;-1;floor(25*n/k);floor(41*n/k);-1;floor(14*n/k);floor(47*n/k);-1;-1;floor(49*n/k);-1];
    hc11 = [-1;-1;-1;-1;floor(72*n/k);-1;floor(18*n/k);-1;-1;floor(70*n/k);-1;-1];
    hc12 = [-1;floor(12*n/k);0;-1;-1;floor(79*n/k);-1;-1;floor(51*n/k);floor(72*n/k);-1;floor(26*n/k)];
    hc13 = [floor(7*n/k);-1;-1;-1;-1;0;-1;-1;-1;-1;-1;floor(7*n/k)];
    hc14 = [0;0;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1];
    hc15 = [-1;0;0;-1;-1;-1;-1;-1;-1;-1;-1;-1];
    hc16 = [-1;-1;0;0;-1;-1;-1;-1;-1;-1;-1;-1];
    hc17 = [-1;-1;-1;0;0;-1;-1;-1;-1;-1;-1;-1];
    hc18 = [-1;-1;-1;-1;0;0;-1;-1;-1;-1;-1;-1];
    hc19 = [-1;-1;-1;-1;-1;0;0;-1;-1;-1;-1;-1];
    hc20 = [-1;-1;-1;-1;-1;-1;0;0;-1;-1;-1;-1];
    hc21 = [-1;-1;-1;-1;-1;-1;-1;0;0;-1;-1;-1];
    hc22 = [-1;-1;-1;-1;-1;-1;-1;-1;0;0;-1;-1];
    hc23 = [-1;-1;-1;-1;-1;-1;-1;-1;-1;0;0;-1];
    hc24 = [-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;0;0];
    
    H_index = cat(2,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,...
      hc13,hc14,hc15,hc16,hc17,hc18,hc19,hc20,hc21,hc22,hc23,hc24);
    
    % temp_H = [row_1,row_3,row_5,row_12,row_7,row_9,row_11,row_2,row_4,row_6,row_8,row_10]
    
    temp_H = cat(1,H_index(1,:),H_index(3,:),H_index(5,:),H_index(12,:),...
      H_index(7,:),H_index(9,:),H_index(11,:),H_index(2,:),...
      H_index(4,:),H_index(6,:),H_index(8,:),H_index(10,:));
    
    clear H_index;
    
    H_index = temp_H;
    
  case 2/3
    hc1 =  [floor(2*n/k);-1;floor(10*n/k);-1;floor(23*n/k);-1;floor(32*n/k);-1];
    hc2 =  [-1;floor(69*n/k);-1;floor(28*n/k);-1;floor(30*n/k);-1;0];
    hc3 =  [floor(19*n/k);-1;floor(86*n/k);-1;floor(29*n/k);-1;0;-1];
    hc4 =  [-1;floor(88*n/k);-1;floor(32*n/k);-1;floor(65*n/k);-1;floor(47*n/k)];
    hc5 =  [floor(47*n/k);-1;floor(62*n/k);-1;floor(15*n/k);-1;floor(15*n/k);-1];
    hc6 =  [-1;floor(47*n/k);-1;floor(81*n/k);-1;floor(54*n/k);-1;floor(13*n/k)];
    hc7 =  [floor(48*n/k);-1;floor(28*n/k);-1;floor(30*n/k);-1;floor(56*n/k);-1];
    hc8 =  [-1;floor(3*n/k);-1;floor(27*n/k);-1;floor(14*n/k);-1;floor(61*n/k)];
    hc9 =  [floor(36*n/k);-1;floor(85*n/k);-1;floor(66*n/k);-1;floor(85*n/k);-1];
    hc10 = [-1;floor(16*n/k);-1;floor(88*n/k);-1;0;-1;floor(84*n/k)];
    hc11 = [floor(82*n/k);-1;floor(16*n/k);-1;floor(24*n/k);-1;floor(5*n/k);-1];
    hc12 = [-1;floor(37*n/k);-1;floor(5*n/k);-1;floor(30*n/k);-1;floor(55*n/k)];
    hc13 = [floor(47*n/k);-1;floor(34*n/k);-1;floor(50*n/k);-1;floor(6*n/k);-1];
    hc14 = [-1;floor(40*n/k);-1;floor(56*n/k);-1;floor(74*n/k);-1;floor(78*n/k)];
    hc15 = [floor(15*n/k);-1;floor(73*n/k);-1;floor(62*n/k);-1;floor(52*n/k);-1];
    hc16 = [-1;floor(48*n/k);-1;floor(37*n/k);-1;0;-1;floor(41*n/k)];
    hc17 = [floor(95*n/k);-1;-1;-1;-1;-1;0;floor(95*n/k)];
    hc18 = [0;0;-1;-1;-1;-1;-1;-1;];
    hc19 = [-1;0;0;-1;-1;-1;-1;-1;];
    hc20 = [-1;-1;0;0;-1;-1;-1;-1;];
    hc21 = [-1;-1;-1;0;0;-1;-1;-1;];
    hc22 = [-1;-1;-1;-1;0;0;-1;-1;];
    hc23 = [-1;-1;-1;-1;-1;0;0;-1;];
    hc24 = [-1;-1;-1;-1;-1;-1;0;0;];
    
    H_index = cat(2,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,...
      hc13,hc14,hc15,hc16,hc17,hc18,hc19,hc20,hc21,hc22,hc23,hc24);
    
    % temp_H = [row_1,row_4,row_7,row_2,row_5,row_8,row_3,row_6]
    
    temp_H = cat(1,H_index(1,:),H_index(4,:),H_index(7,:),H_index(2,:),...
      H_index(5,:),H_index(8,:),H_index(3,:),H_index(6,:));
    
    clear H_index;
    
    H_index = temp_H;
    
  case 3/4
    hc1 =  [floor(6*n/k);floor(62*n/k);floor(71*n/k);floor(38*n/k);-1;-1];
    hc2 =  [floor(38*n/k);floor(94*n/k);-1;floor(61*n/k);-1;floor(63*n/k)];
    hc3 =  [floor(3*n/k);floor(19*n/k);floor(55*n/k);-1;-1;floor(31*n/k)];
    hc4 =  [floor(93*n/k);floor(84*n/k);-1;floor(66*n/k);-1;floor(88*n/k)];
    hc5 =  [-1;-1;floor(12*n/k);floor(9*n/k);floor(32*n/k);floor(20*n/k)];
    hc6 =  [-1;floor(92*n/k);floor(66*n/k);floor(73*n/k);floor(52*n/k);-1];
    hc7 =  [-1;floor(78*n/k);floor(45*n/k);floor(47*n/k);floor(55*n/k);-1];
    hc8 =  [floor(30*n/k);-1;floor(79*n/k);floor(64*n/k);floor(80*n/k);-1];
    hc9 =  [floor(70*n/k);floor(15*n/k);-1;-1;floor(95*n/k);floor(6*n/k)];
    hc10 = [-1;-1;floor(78*n/k);floor(39*n/k);floor(22*n/k);floor(40*n/k)];
    hc11 = [floor(86*n/k);-1;-1;floor(61*n/k);floor(6*n/k);floor(56*n/k)];
    hc12 = [-1;floor(92*n/k);-1;floor(43*n/k);floor(51*n/k);floor(16*n/k)];
    hc13 = [floor(37*n/k);-1;floor(10*n/k);-1;floor(24*n/k);floor(71*n/k)];
    hc14 = [floor(38*n/k);floor(45*n/k);-1;-1;floor(90*n/k);floor(53*n/k)];
    hc15 = [floor(4*n/k);floor(24*n/k);floor(22*n/k);-1;floor(44*n/k);-1];
    hc16 = [floor(11*n/k);floor(32*n/k);floor(55*n/k);-1;floor(20*n/k);-1];
    hc17 = [-1;floor(30*n/k);floor(70*n/k);floor(95*n/k);-1;floor(27*n/k)];
    hc18 = [floor(46*n/k);-1;floor(82*n/k);floor(32*n/k);-1;floor(26*n/k)];
    hc19 = [floor(48*n/k);-1;-1;0;-1;floor(48*n/k)];
    hc20 = [0;0;-1;-1;-1;-1];
    hc21 = [-1;0;0;-1;-1;-1];
    hc22 = [-1;-1;0;0;-1;-1];
    hc23 = [-1;-1;-1;0;0;-1];
    hc24 = [-1;-1;-1;-1;0;0];
    
    H_index = cat(2,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,...
      hc13,hc14,hc15,hc16,hc17,hc18,hc19,hc20,hc21,hc22,hc23,hc24);
    
  otherwise
    error('ldpc_matrix_80216e error: code rate is not supported');
end
 

