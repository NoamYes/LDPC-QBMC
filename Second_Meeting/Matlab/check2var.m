function [var] = check2var(Mat, QM)

var = zeros(1,length(Mat));
    for i = 1:length(Mat)
        if isempty(find(~Mat(i,:), 1)) %if we didn't find 0 in the row i in
            %the matrix, put a QM in the var vector.
            var(i) = QM;
        else
            var(i) = 0;
        end
    end
    
 end
