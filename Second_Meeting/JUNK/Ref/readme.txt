Documentation for TDMP LDPC decoder

Author : Miroslav Marinkovic
E-mail : mmarinkovic78d@gmail.com


1. Introduction

The TDMP (Turbo-Decoding Message-Passing) algorithm for decoding LDPC codes
is known in literature also as the layered decoding algorithm. 
The main advantages of the TDMP algorithm over the standard two-phase message passing algorithm are
faster convergence and reduced memory requirements.
The TDMP algorithm is suitable for decoding architecture-aware subclass of
LDPC codes (AA-LDPC) such as the LDPC codes from standards 
IEEE 802.11n, IEEE 802.16e (WiMAX), IEEE 802.11ad, IEEE 802.15.3c, ... 

In this project we want to estimate the performance the TDMP decoder. 
As a reference decoder, the Matlab build-in decoder from the communications toolbox is used.
The Matlab decoder uses the standard two-phase message-passing algorithm.
For performance estimation, the LDPC codes from IEEE 802.11n, IEEE 802.16e,
IEEE 802.11ad, IEEE 802.15.3c are currently used.
 
2. Files

This readme.txt file, documentation for TDMP LDPC decoder.

ldpc_decoder_TDMP.m

  The TDMP decoder. It employs the Normalized Min-Sum algorithm (NMS). Fixed-point implementation.

ldpc_decoder_TDMP_struct.m

  This function stores in a structure all parameters for the TDMP decoder.
  
quantization_func.m
  
  The quantization function. Required for fixed-point implementation.

generate_ldpc_matrix_80216e.m

  This function generates the parity-check matrix for IEEE 802.16e (WiMAX). 
  Code-rate : 1/2, 2/3, 3/4.
  
generate_ldpc_matrix_80211n.m

  This function generates the parity-check matrix for IEEE 802.11n. 
  Code-rate : 1/2, 2/3, 3/4 and 5/6.

generate_ldpc_matrix_80211ad.m

  This function generates the parity-check matrix for IEEE 802.11ad. 
  Code-rate : 1/2, 5/8, 3/4 and 13/16.

generate_ldpc_matrix_802153c.m

  This function generates the parity-check matrix for IEEE 802.15.3c. 
  Code-rate : 1/2, 5/8, 3/4 and 7/8.
  
sim_perf_estimation.m

  The simulation script that estimates the performance (BER, FER, number of iterations performed) of the TDMP decoder versus
  the Matlab built-in decoder from the communications toolbox.
	
sim_res_BER_FER.jpg
 
  Bit Error Rate (BER) and Frame Error Rate (FER) obtained by simulations. The LDPC(1536,768) code has been selected.
  The maximum number of decoding iterations is 10.
  Since the maximum number of iterations is relatively small,
  it can be seen a significant advantage of the TDMP decoder over the Matlab build-in decoder.   

average_num_iterations.jpg
  
  Average number of iterations performed until convergence.
  A faster convergence speed of the TDMP decoder is clearly illustrated.  
