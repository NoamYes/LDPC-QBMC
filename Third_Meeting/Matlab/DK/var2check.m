%% the function gets the Matrix
%  the function returns the check2var calculation over a vector

function [var] = var2check(Mat_t, q, intersectMat)
    %can make here intersect matrix
    [row, ~] = size(Mat_t);
    var = zeros(1,row)+1; %create a 'zero' vector 
    for i=1:row
        vec = unique(Mat_t(i,:)); %find different groups in the matrix
        grouptmp = log2(q)+1; %initialize the tmp var as the whole set
        for j=vec %run on all the diff gorups
            grouptmp = intersectMat(grouptmp,j); %find the intersection of
            % all the groups using the matrix
        end
        var(i) = grouptmp;
    end
    
end
