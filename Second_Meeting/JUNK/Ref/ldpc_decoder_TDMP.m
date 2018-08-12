% Author : Miroslav Marinkovic
% E-mail : mmarinkovic78d@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function s_info = ldpc_decoder_TDMP(x, s_ldpc, n_it)

% Normalized Min-Sum (NMS) algorithm
% Turbo-Decoding Message-Passing (TDMP) or Layered decoding schedule
% Fixed-point implementation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x - input vector of APP messages;
% n_it - number of iteration;
% s_ldpc - ldpc structure, see ldpc_decoder_TDMP_struct.m
% Early Termination strategy : Hc-checking

s = s_ldpc;
clear s_ldpc;
H_sparse = s.H_sparse;

% size of the parity-check matrix H_sparse
[M, N] = size(H_sparse);

% sub-matrix size
size_subm = s.size_subm;

% normalization factor for check-to-variable messages
sc_factor = s.scaling_factor;

% bit-width of input a-posteriori (APP) messages
n_bit = s.n_bit;

% bit-width of internal APP
n_bit_L = s.n_bit_L;

% bit-width of R messages
n_bit_R = s.n_bit_R;

% clipping (1/0)
clip_on = s.clip_on;

% early termination of decoding (1/0)
alg_term = s.alg_term;

% scaling factor for initial bit-metrics
scaling_factor_in = (1 - 2^(-(n_bit - 1)))/s.clip_value;

% maximum value for APP messages
L_max = 2^(n_bit_L - n_bit);

% maximum value for R messages
R_max = 2^(n_bit_R - n_bit);

% address for APP messages
addr_rd_app = s.addr_rd_app;

% pattern for permutation network (barrel shifter)
addr_barrel = s.addr_barrel;

% correction factor to eliminate negative overflow effects for fixed-point impl.
A_corr = s.A_corr;

% row weight of each layer of parity-check matrix
row_weight = s.row_weight;

% cumulative sum of row weights
ind_weight = s.index_weight;

% number of horizontal layers
num_layers = length(ind_weight) - 1;

% scaling and quantization of initial APP
x = double(x(:).')*scaling_factor_in;
x = quantization_func(x, n_bit, 1);
L = reshape(x, size_subm, N/size_subm)';

% Initialize the number of executed iteration
n_it_exe = n_it;

% Initialize the number of executed layers
n_layers_exe = 0;

% Decoding algorithm convergance: inital value is false(0)
alg_converge = 0;

% Initialization to zero
R = zeros(ind_weight(end), size_subm);
Q = zeros(ind_weight(end), size_subm);
L_rd = zeros(N/size_subm, size_subm);
L_perm = zeros(N/size_subm, size_subm);
L_new = zeros(N/size_subm, size_subm);
sign_Q = zeros(ind_weight(end), size_subm);
abs_Q = zeros(ind_weight(end), size_subm);

% initialize the iteration counter
i = 1;

% main loop - decoding iterations
while (i <= n_it && alg_converge == 0)
  
  n_layers_exe = 0;
  
  % processing of horizontal layers of the parity-check matrix
  % inside each layer, only non-zero sub-matrices are processed
  for i_layer = 1 : num_layers
    
    % row vector - sub-matrix index
    i_subm = ind_weight(i_layer) + 1 : ind_weight(i_layer + 1);
    
    % read L_rd a-posteriori probability (APP) messages
    L_rd(i_subm,:) = L(addr_rd_app(i_subm),:);
    
    for k = i_subm(1) : i_subm(end)
      % permutation of APP messages (the first Barrel shifter)
      L_perm(k,:) = circshift(L_rd(k,:),[1 addr_barrel(k)]);
    end
    
    % THE FIRST STEP OF DECODING
    
    % check saturation of APP messages
    ch_sat_L = 2^(n_bit - 1)*abs(L_perm(i_subm,:)) == 2^(n_bit_L - 1) - 1;
    
    % calculate variable-to-check messages
    % correction factor A_corr is introduced
    Q(i_subm,:) =  L_perm(i_subm,:) - R(i_subm,:) + A_corr * (ch_sat_L.*R(i_subm,:));
    
    % clipping
    if clip_on
      Q(i_subm,:) = quantization_func(Q(i_subm,:), n_bit_L, L_max);
    end
    
    % THE SECOND STEP OF DECODING
    
    sign_Q(i_subm,:) = 2*(Q(i_subm,:)>=0) - 1; % sign
    abs_Q(i_subm,:)  = abs(Q(i_subm,:));       % magnitude
    
    % sort in ascending order
    [abs_sort,ind_sort] = sort(abs_Q(i_subm,:),'ascend');
    
    % find the first as well as the second minimum
    min1 = abs_sort(1,:); % size [1 x size_subm]
    min2 = abs_sort(2,:); % size [1 x size_subm]
    
    % find the index of the first minimum
    index_min1 = ind_sort(1,:); % size [1 x size_subm]
    
    % sign product
    sign_prod = prod(sign_Q(i_subm,:));  % size [1 x size_subm]
    
    sign_prod = repmat(sign_prod,row_weight(i_layer),1);  % size [row_weight(i_layer) x size_subm]
    
    min12 = repmat(min1,row_weight(i_layer),1);           % size [row_weight(i_layer) x size_subm]
    
    % replace the first minimum with the second at the appropriate
    % positions
    for k = 1 : size_subm
      min12(index_min1(k),k) = min2(k);
    end
    
    min12_factor = quantization_func((1 - sc_factor)*min12, n_bit_L - 1, L_max/2);
    % scaling by "sc_factor" is done by subtraction
    min12 = min12 - min12_factor;
    
    % calculate check-to-variable messages (R)
    R(i_subm, :) = sign_prod .* (sign_Q(i_subm, :) .* min12);
    
    % clipping
    if clip_on
      R(i_subm, :) = quantization_func(R(i_subm, :), n_bit_R, R_max);
    end
    
    % THE THIRD STEP OF DECODING
    
    % update APP messages
    L_new(addr_rd_app(i_subm),:) = Q(i_subm,:) + R(i_subm,:);
    
    for k = i_subm(1) : i_subm(end)
      % De-permutation of APP messages (the second Barrel shifter)
      L(addr_rd_app(k),:) = circshift(L_new(addr_rd_app(k),:),[1 size_subm - addr_barrel(k)]);
    end
    
    % clipping
    if clip_on
      L = quantization_func(L, n_bit_L, L_max);
    end
    
    L_row_vec = reshape(L', 1, N);
    
    % hard decision
    y = (L_row_vec < 0);
    
    if alg_term
      % check whether a valid codeword has been found
      z = mod(H_sparse * y', 2);
      if sum(z) == 0
        n_it_exe = i - 1;
        n_layers_exe = i_layer;
        alg_converge = 1;
        break
      end
    end
    
  end % for loop
  
  % increment the iteration counter
  i = i + 1;
  
end % main loop

% save in the s_info structure :
% the decoded bits
% the number of iterations as well as number of layers
% performed until convergence

if n_it > 0
  s_info.decoded_bits = y(1:N-M);
else % n_it == 0
  % extract decoded bits directly from input 
  s_info.decoded_bits = (x(1:N-M) < 0);
end

s_info.n_it_exe = n_it_exe;
s_info.n_layers_exe = n_layers_exe; 

end