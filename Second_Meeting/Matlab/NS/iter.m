function [ NoiseRatio ] = iter( H, noised, QM, iterLen )

% this function basically takes the added noise transmitted vector
% given the H parity Check Matrix and return the decoded vec
% base on this code, all using message passing and iterations

%  - H: rows - checks, columns - variables

% calculate adjacency list using cell array, each adj{i} contains the
%array of indiced variables nodes check {j} is connected to

[c, r] = find(H.');
c_v_adj = accumarray(r, c, [size(H,1), 1], @(L) {L.'} );

[c, r] = find(H);
v_c_adj = accumarray(r, c, [size(H.',1), 1], @(L) {L.'} );

% first, variables trasmit the noise vector, initialize var2check

var_tmp = v_c_adj;
for i = 1:length(noised)
    var_tmp{i}(:) = noised(i);
end


var2c_itr = var_tmp;
c2v_init = c_v_adj;

% initialize check2var to be all QM
for i = 1:length(c_v_adj)
    for j = 1:length(c_v_adj{i})
        c2v_init{i}(j)=QM;
    end
end





% first iteration for check2var
c2v_vec = check2var(c2v_init,var2c_itr, c_v_adj, QM, v_c_adj);

% looping for number of iterations till convergence

for itr = 1:iterLen
    
    last = var2c_itr;
    var2c_itr = var2check(var2c_itr, c2v_vec, v_c_adj, QM, c_v_adj);
    if isequal(last,var2c_itr)
        break;
    end
    c2v_vec = check2var(c2v_vec, var2c_itr, c_v_adj, QM, v_c_adj);
    
end

%should be the decoded word, final var2c_itr contains the final word

decoded = deCell(var2c_itr, QM).';

   end_noise = sum(decoded(:) == QM);
    NoiseRatio = end_noise/length(decoded); %return the ratio of noise

end

