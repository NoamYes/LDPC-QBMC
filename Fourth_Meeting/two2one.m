function [out] = two2one(q, subArr, intersectMat)
%FIVE2ONE 
% |subArr| = dv - 1
     out = log2(q)+1;
     for j=subArr %run on all the diff gorups
        out = intersectMat(out,j); %find the intersection of
        % all the groups
    end
end

