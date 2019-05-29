function [PiMatrix] = PiCalcUnion(q, dc, tranMat, kapa)


sizesNum = log2(q)+1;
set_vec = sizesNum*ones(1, dc-1);
set_mat = zeros(set_vec);
PiMatrix = cell(set_vec);
vec_ndims = ndims(set_mat);
vec_mat_size = size(set_mat);

for idx_vec = 1:numel(set_mat)
    
    I = cell(1, vec_ndims);
    [I{:}] = ind2sub(vec_mat_size,idx_vec);
    sub_idx_vec = cell2mat(I);
    idxCell = num2cell(sub_idx_vec);
    sizeArray = 2.^(sub_idx_vec-1);
    PiMatrix{idxCell{:}} = UnionModel(q,sizeArray, tranMat, kapa);

end

end

