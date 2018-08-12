%% the function gets the Matrix and the QM as input and creates a vector of
%  var so the if there is a 0 in the row, it will be a 0 and if not, a QM.

function [var] = check2var(Mat, QM)

    [~, col] = size(Mat); %get the number of col of the matrix
    var = zeros(1,col); %create a zero vec in the correct length
    for i = 1:col
        if isempty(find(~Mat(:,i), 1)) %if we didn't find 0 in the col i in
            %the matrix, put a QM in the var vector.
            var(i) = QM;
        end
    end
end 
