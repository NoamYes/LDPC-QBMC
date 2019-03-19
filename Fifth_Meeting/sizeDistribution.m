function [sizeDist,sizeDistPerc] = sizeDistribution(dc,q)

%% analytic solution of the size distribution - only 2^m sizes subgroups 

maxS = log2(q)+1;
i = 1:maxS;
combsNum = arrayfun(@nchoosek,dc-2+i-1,i-1);
qSizeNum = (maxS)^(dc-1)-sum(combsNum(1:end-1));
sizeDist = [combsNum(1:end-1) qSizeNum];
sizeDistPerc = sizeDist/sum(sizeDist);

end

