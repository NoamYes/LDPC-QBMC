function [probMat] = probMatrix(q, dc, L_vec)
%PRONMATRIX Summary of this function goes here
%   Detailed explanation goes here
    const_vec = (q-1)*ones(1, dc);
    probMat = zeros(const_vec);
    n_dims = ndims(probMat);
    Mat_size = size(probMat);
    for i = 1:numel(probMat)
        I = cell(1, n_dims); 
        [I{:}] = ind2sub(Mat_size,i);
        probMat(i) = prod(L_vec(cell2mat(I)));
    end
    
end

