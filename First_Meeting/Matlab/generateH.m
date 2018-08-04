%% This function generates a random parity matrix for a given n,k.

%need to add for future use: dv and dc to the code.
function [H] = generateH(n,k, ~, ~)
    H =  randi([0 1],n-k,n); %(n-k) by n martix with random 0 and 1
end