% Author : Miroslav Marinkovic
% E-mail : mmarinkovic78d@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates the structure which contains the LDPC parameters
% for the decoding function "ldpc_decoder_TDMP"

function s = ldpc_decoder_TDMP_struct(code_rate, clip_value,...
  n_bit, clip_on, size_subm, n_bit_L, n_bit_R, scaling_factor, alg_term, A_corr, ldpc_standard)

if nargin ~= 11
  error('Error : Number of input arguments is incorrect');
end;

switch ldpc_standard
  case '802.16e'
    [H_index] = generate_ldpc_matrix_80216e(size_subm, code_rate);
  case '802.11n'
    [H_index] = generate_ldpc_matrix_80211n(size_subm, code_rate);
  case '802.11ad'
    [H_index] = generate_ldpc_matrix_80211ad(size_subm, code_rate);
  case '802.15.3c'
    [H_index] = generate_ldpc_matrix_802153c(size_subm, code_rate);
  otherwise
    error('Error : LDPC standard not found');
end

% size of H_index matrix
[num_row, num_col] = size(H_index);

% code rate
s.code_rate = code_rate;

% correction factor to reduce some negative overlow effects under
% finite word-length decoder implementation
s.A_corr = A_corr;

% clipping value
s.clip_value = clip_value;

% input APP bit-width
s.n_bit = n_bit;

% clip_on -  1(on); 0(off):
s.clip_on = clip_on;

% algorithm termination -  1(on); 0(off):
s.alg_term = alg_term;

% sub-matrix size - number of rows in a single layer
s.size_subm = size_subm;

% bit-width of internal APP
s.n_bit_L = n_bit_L;

% bit-width of check-to-variable (R) messages
% usually the same as the bit-width of internal APP
s.n_bit_R = n_bit_R;

% scaling factor
s.scaling_factor = scaling_factor;

% read pattern for APP messages
addr_rd_app = [ ];

% pattern for permutation network (Barrel shifter)
addr_barrel = [ ];

% row weight (number of ones in a single row)
row_weight = zeros(1, num_row);

for i_row = 1 : num_row
  addr = find(H_index(i_row,:) ~= -1);
  addr_rd_app = cat(2, addr_rd_app, addr);
  
  row_weight(i_row) = length(addr);
  
  addr_barrel_row = H_index(i_row, H_index(i_row,:) ~= -1);
  addr_barrel = cat(2, addr_barrel, addr_barrel_row);
end

addr_barrel = -addr_barrel + size_subm;
addr_barrel = mod(addr_barrel, size_subm);

% create the sparse parity-check matrix H_sparse based on H_index
for i_row = 1 : num_row
  for i_col = 1 : num_col
    if H_index(i_row,i_col) == -1
      H_sparse(1+(i_row-1)*size_subm : i_row*size_subm, 1+(i_col-1)*size_subm : i_col*size_subm) ...
        = sparse(zeros(size_subm, size_subm));
    else
      H_sparse(1+(i_row-1)*size_subm : i_row*size_subm, 1+(i_col-1)*size_subm : i_col*size_subm) ...
        = sparse(circshift(eye(size_subm), -H_index(i_row,i_col)));
    end
  end
end

% save in structure
s.addr_rd_app = addr_rd_app;
s.addr_barrel = addr_barrel;
s.row_weight = row_weight;
s.index_weight = cat(2, zeros(1,1), cumsum(row_weight));
s.H_sparse = H_sparse;

end

