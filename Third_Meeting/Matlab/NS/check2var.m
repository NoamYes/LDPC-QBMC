%% the function gets the Matrix of varCheck, H mat, the var vector and QM
% it checks each variable in each check what is the value of the other vars
% and if they are all 0, Matrix in that check and var will be 0, else QM.

function [c2v] = check2var(H, v2c, v2c_s, c2v_s, lookMat, divideMat)

Max = size(divideMat,1);
mat = zeros(size(H));
mat(v2c_s.idxs) = v2c;
c2v_tmp = mat(c2v_s.idxs); % map from v2c matrix to c2v matrix
%     reped = repmat(c2v_tmp, [1,1, size(c2v_tmp,2)]);
reped = zeros(size(c2v_tmp));
v2c_tmp = c2v_tmp;
mult = c2v_s.vals; % H cooresponding values to multiply
n = size(mult,1);
masked_mat = v2c_tmp;
for i = 1:size(c2v_tmp,2)
    
    masked_mat(:,i) = 0;
    %          sum_set = @(k,j) sumset(mult(k,:),masked_mat(j,:), i, lookMat, divideMat);
    %          reped(:,i) = arrayfun(sum_set, 1:n, 1:n);
    [RowsMax, ~] = find(masked_mat == Max);
    reped(RowsMax,i) = Max;
    NotMax = find(reped(:,i) ~= Max);
    if(~isempty(NotMax))
        for idx = 1:numel(NotMax) 
            s = NotMax(idx);
            reped(s,i) = sumset(mult(s,:),masked_mat(s,:), i, lookMat, divideMat);
        end
    end
    masked_mat = v2c_tmp;
end

c2v = reped;


end

