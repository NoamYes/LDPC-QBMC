%% the function gets the Matrix and the QM as input and creates a vector of
%  var so the if there is a 0 in the row, it will be a 0 and if not, a QM.

function [var] = check2var2(Mat_t, var)

    [QM_row, ~] = find(~Mat_t); %find values that are 0
    var(QM_row) = 0; %if there are 0's in the col, then put a 0 in the var
    
end 
