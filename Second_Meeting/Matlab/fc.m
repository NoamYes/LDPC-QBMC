function [ value ] = fc( v_arr, QM )

% fc gets a vector of values from checks to current var except
% for the check whose message passes from 

if sum(v_arr == QM) == 0 
    
    value = mod(sum(v_arr),2);
else
    value = QM;
end
