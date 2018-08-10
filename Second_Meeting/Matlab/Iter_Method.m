function [ decoded ] = Iter_Method( H, noised )
% this function basically takes the added noise transmitted vector 
% given the H parity Check Matrix and return the decoded vec
% base on this code, all using message passing and iterations

%  - H: rows - checks, columns - variables

% calculate adjacency list using cell array, each adj{i} contains the
%array of indiced variables nodes check {j} is connected to

[c, r] = find(H.');
adj = accumarray(r, c, [size(H,1), 1], @(L) {L.'} );

var_itr = noised;
var_feedback = check2var(H,var_itr,adj);
% for iterations do

var_feedback = check2var(
end

