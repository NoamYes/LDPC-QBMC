function [var] = iter(H, vec, QM, iter_len)
% tic
    [row, ~] = size(H);
    Mat = repmat(vec,[row,1]); %initiate a matrix like H with all the repeat
    %of the vector vec
    var = vec; %initate the var vector
    for i = 1:iter_len
        Mat = var2check(Mat, H, var);
        var = check2var(Mat, QM);
    end
% toc
end

