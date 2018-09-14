%% the function gets the Matrix
%  the function returns the check2var calculation over a vector

function [var] = var2check(Mat_t, subCell, q)
    %can make here intersect matrix
    [row, ~] = size(Mat_t);
    var = zeros(1,row);
    for i=1:row
        vec = unique(Mat_t(i,:));
        group = subCell{log2(q)+1};
        for j=vec
            group = intersect(group,subCell{j});
        end
        isSub = cellfun(@(x)isequal(x,group),subCell);
        loc = find(isSub);
        var(i) = loc;
    end
    
end