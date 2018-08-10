function [ value ] = fc( v_arr, QM, current_node )

% fc gets a vector of values from checks to current var except
% for the check whose message passes from
% if at all of edges from variable to checks contain notQM - 
% the vector above contains only notQM => the variable will be the mod of
% the sum of the other variables

if sum(v_arr == QM) == 0
    
    value = mod(sum(v_arr),2);
else
    value = QM;
end
