function [ decoded ] = Iter_Method( H, noised, QM )
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

% first, variables trasmit the noise vector

var_tmp = v_c_adj;
for i = 1:length(noised)
    
    var_tmp{i}(:) = noised(i);
    
end

var_itr = var_tmp;

var_feedback = check2var(var_itr, c_v_adj, QM);

for itr = 1:100;

var_itr = var2check(var_feedback, v_c_adj, QM);
var_feedback = check2var(var_itr, c_v_adj, QM);

end

decoded = var_itr{:}(1);

end

