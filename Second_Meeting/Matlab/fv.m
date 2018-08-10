function [ value ] = fv( c_arr, QM )

% fc gets a vector of values from checks to current var except
% for the check whose message passes from 

if sum(c_arr ~= QM) == 0 
    
    value = QM;
else
    tmp = c_arr(c_arr ~= QM);
    value = tmp(1);
end

