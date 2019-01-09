function [ intersectMat ] = intersect_lookup( subsetTable )
%INTERSECT_LOOKUP Summary of this function goes here
%   Detailed explanation goes here

setsNum = length(subsetTable);
intersectMat = zeros(setsNum);

for i = 1:setsNum
    for j = 1:setsNum
        
        intersected = intersect(subsetTable{i},subsetTable{j});
        isSub = cellfun(@(x)isequal(x,intersected),subsetTable);
        loc = find(isSub);
        intersectMat(i,j) = loc;
        
    end
end

end

