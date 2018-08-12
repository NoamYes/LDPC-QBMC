% Author : Miroslav Marinkovic
% E-mail : mmarinkovic78d@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This simulation script estimates the performance of the TDMP Decoder (based
% on the normalized min-sum algorithm) versus the Matlab Decoder from the
% communications toolbox

clear all;
clc;

% define the ratio of bit energy to noise power spectral density in dB (EbN0_dB) as a row vector
EbN0_dB = [3.0 3.1 3.2];
EbN0 = 10.^(EbN0_dB / 10);

% maximum number of decoding iterations
n_it_max = 10;

% number of LDPC frames
n_ldpc_frames = [5e3 5e3 5e3];

% code rate
code_rate = 1/2;

% BPSK modulation scheme
Es = 1;
Eb = Es/code_rate;
N0 = repmat(Eb,1,length(EbN0_dB))./EbN0;

% set the parameters of TDMP Decoder

% input APP bit-width
n_bit = 5;

% submatrix size of the parity-check matrix
size_subm = 42;

% internal APP bit-width
n_bit_L = 8;

% R messages bit-width
n_bit_R = 8;

% normalization scaling factor for check-to-variable messages
scaling_factor = 0.8125;

% algorithm termination (parity check)
alg_term = 1;

% correction factor to reduce some negative overflow effects under
% finite word-length decoder implementation
A_corr = 1;

% clipping
clip_on = 1;

% clipping value for input APP values
clip_value = (1-2^(-(n_bit-1)))/0.5;

ldpc_standard = '802.11ad';

% set up the structure for decoder
s_TDMP = ldpc_decoder_TDMP_struct(code_rate, clip_value,...
  n_bit, clip_on, size_subm, n_bit_L, n_bit_R, scaling_factor, alg_term, A_corr, ldpc_standard);

% sparse parity check matrix
H_sparse = s_TDMP.H_sparse;

[n_rows_H, n_col_H] = size(H_sparse);

n_source_bits = n_col_H - n_rows_H;

% create LDPC encoder object
henc = comm.LDPCEncoder(H_sparse);

% create LDPC decoder object
hdec = comm.LDPCDecoder(H_sparse, ...
  'IterationTerminationCondition', 'Parity check satisfied', ...
  'MaximumIterationCount', n_it_max, ...
  'NumIterationsOutputPort', true);

L = length(EbN0_dB);

fprintf('\n');
fprintf('*************************************************************\n');
fprintf('** TDMP LDPC decoder vs. Reference Matlab build-in decoder **\n');
fprintf('*************************************************************\n');
fprintf('\n');

for i_EbN0_dB = 1 : L
  
  err_bits_TDMP = 0;
  n_fer_TDMP = 0;
  
  err_bits_reference = 0;
  n_fer_reference = 0;
  
  n_it_exe_TDMP = zeros(1,n_ldpc_frames(i_EbN0_dB));
  n_layers_exe_TDMP = zeros(1,n_ldpc_frames(i_EbN0_dB));
  n_it_exe_reference = zeros(1,n_ldpc_frames(i_EbN0_dB));
  
  avg_n_iter_TDMP = zeros(1,n_ldpc_frames(i_EbN0_dB));
  avg_n_layers_TDMP = zeros(1,n_ldpc_frames(i_EbN0_dB));
  
  fprintf('global iteration %d/%d for EbN0_dB = %.2f\n\n', i_EbN0_dB, L, EbN0_dB(i_EbN0_dB));
  
  for i_ldpc_frames = 1 : n_ldpc_frames(i_EbN0_dB)
    
    % generate random bits
    x = rand(1,n_source_bits)<0.5;
    
    % LDPC coding
    xc = step(henc, x');
    
    % BPSK Modulation
    tx = 1 - 2*xc;
    
    % add noise (AWGN)
    rx = tx' + sqrt(N0(i_EbN0_dB)/2)*randn(1, n_col_H);
    tic
    % TDMP Decoder
    s_info_decoder = ldpc_decoder_TDMP(rx, s_TDMP, n_it_max);
    toc;
    % Matlab build-in Decoder (reference decoder)
    [decoded_bits, n_it_reference] = step(hdec, 4*rx'/N0(i_EbN0_dB));
    
    % update the number of erroneous bits and number of erroneous
    % frames (TDMP Decoder)
    err_bits_TDMP_new = sum(s_info_decoder.decoded_bits ~= x);
    err_bits_TDMP = err_bits_TDMP + err_bits_TDMP_new;
    n_fer_TDMP = n_fer_TDMP + (err_bits_TDMP_new > 0);
    
    % update the number of erroneous bits and number of erroneous
    % frames (Matlab Decoder)
    err_bits_reference_new = sum(decoded_bits' ~= x);
    err_bits_reference = err_bits_reference + err_bits_reference_new;
    n_fer_reference = n_fer_reference + (err_bits_reference_new > 0);
    
    % number of decoding iterations performed until convergence
    % additionally, the number of layers performed in the last
    % iteration for TDMP Decoder
    n_it_exe_TDMP(i_ldpc_frames) = s_info_decoder.n_it_exe;
    n_layers_exe_TDMP(i_ldpc_frames) = s_info_decoder.n_layers_exe;
    
    % number of decoding iterations performed until convergence (Matlab Decoder)
    n_it_exe_reference(i_ldpc_frames)  = n_it_reference;
    
    % print simulation results periodically on the screen
    if mod(i_ldpc_frames, 100) == 0
      fprintf('n_ldpc_frames_decoded : %d/%d\n', i_ldpc_frames, n_ldpc_frames(i_EbN0_dB));
      % TDMP Decoder
      fprintf('err_bits_TDMP : %d\n', err_bits_TDMP);
      fprintf('err_frames_TDMP : %d\n', n_fer_TDMP);
      
      % Matlab reference decoder
      fprintf('err_bits_reference : %d\n', err_bits_reference);
      fprintf('err_frames_reference : %d\n\n', n_fer_reference);
    end
  end
  
  % save the simulation results (BER and FER)
  s_info.BER_TDMP(i_EbN0_dB) = err_bits_TDMP/(n_ldpc_frames(i_EbN0_dB)*n_source_bits);
  s_info.FER_TDMP(i_EbN0_dB) = n_fer_TDMP/(n_ldpc_frames(i_EbN0_dB));
  
  s_info.BER_reference(i_EbN0_dB) = err_bits_reference/(n_ldpc_frames(i_EbN0_dB)*n_source_bits);
  s_info.FER_reference(i_EbN0_dB) = n_fer_reference/(n_ldpc_frames(i_EbN0_dB));
  
  % save the average number of decoding iterations
  avg_n_iter_TDMP(i_EbN0_dB) = mean(n_it_exe_TDMP);
  avg_n_layers_TDMP(i_EbN0_dB) = mean(n_layers_exe_TDMP);
  
  s_info.avg_n_iter_TDMP(i_EbN0_dB) = avg_n_iter_TDMP(i_EbN0_dB) + avg_n_layers_TDMP(i_EbN0_dB)/length(s_TDMP.row_weight);
  s_info.avg_n_iter_reference(i_EbN0_dB) = mean(n_it_exe_reference);
  
end

% save the simulation parameters in the structure s_info
s_info.EbN0_dB = EbN0_dB;
s_info.n_it_max = n_it_max;
s_info.n_ldpc_frames = n_ldpc_frames;
s_info.total_n_source_bits = n_source_bits*n_ldpc_frames;
s_info.s_TDMP = s_TDMP;
 
 