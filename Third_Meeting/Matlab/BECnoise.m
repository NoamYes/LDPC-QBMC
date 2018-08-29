%% This function get the vector length and a chance of erased data epsilon
% and returns a vector with the erasion

function [output] = BECnoise(n, e_vec) %for size(e_vec) > 1

    epsilon = sum(e_vec);
    erasion_vec = rand(1,n) > 1 - epsilon; %vector of logical 0 and 1 where there is an erasion
    output = 1*erasion_vec; %turn into a int vec
    for i = numel(e_vec):-1:2  %for i = 1 do nothing, stay with logical 1
        tmp = erasion_vec .* rand(1,n) > 1 - e_vec(i)/epsilon; %vector of logical 1 where the values should be 2^i-1
        output(tmp) = 2^i - 1; %put the value of 2^i - 1 in the output
        erasion_vec(tmp) = 0; %put a 0 in the erasion vec because it now holds a value
        epsilon = epsilon - e_vec(i); %remove the one we used
    end
    
end