%% the function gets the Matrix
%  the function returns the check2var calculation over a vector

function [var] = var2check(Mat_t, subCell, q, intersectMat)
    %can make here intersect matrix
    [row, ~] = size(Mat_t);
    var = zeros(1,row);
%     tic
    for i=1:row
%         tic
        vec = unique(Mat_t(i,:));
%         toc;
        grouptmp = log2(q)+1;
        for j=vec
            grouptmp = intersectMat(grouptmp,j);
        end
        var(i) = grouptmp;
    end
%     toc;
    
end
