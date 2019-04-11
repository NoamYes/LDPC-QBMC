function [size] = subgroupSize(svtc, q)
% input - svtc Hmcombination of subgroups
% output the size of the output subgroups at 1..log2q+1

    H_idx = num2cell(2.^(svtc-1));
    multiSize = prod((cell2mat(H_idx)));
    if multiSize >= q
        multiSize = q;
    end
    size = log2(multiSize)+1;
end

