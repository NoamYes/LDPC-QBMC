%% the function gets the Matrix and the QM as input and creates a vector of
%  var so the if there is a 0 in the row, it will be a 0 and if not, a QM.

function [var] = check2var2(Mat, QM)

    [~, col] = size(Mat); %get the number of col of the matrix
    var = zeros(1,col) + QM; %create a QM vec in the correct length
    [~, QM_col] = find(~Mat); %find values that are 0
    var(QM_col) = 0; %if there are 0's in the col, then put a 0 in the var
    
end 
