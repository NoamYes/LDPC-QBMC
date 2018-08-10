function [ value ] = fv( c_arr, QM, current_node )

% fc gets a vector of values from checks to current var except
% for the check whose message passes from
% if at least one of edges from variable to checks contains notQM - 
% the variable will transmit that via var2check

if sum(c_arr ~= QM) ~= 0
    
    tmp = c_arr(c_arr ~= QM);
    value = tmp(1);
else
    value = current_node;
end

