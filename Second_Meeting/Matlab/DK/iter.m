function [output] = iter(H, vec, QM, iter_len)

    [row, ~] = size(H);
    Mat = repmat(vec,[row,1]); %initiate a matrix like H with all the repeat
    %of the vector vec
    var = vec; %initate the var vector
    for i = 1:iter_len
        Mat = var2check(Mat, H, var);
        var = check2var(Mat, QM);
    end
    
    new_noise = sum(var(:) == QM);
    output = new_noise/length(var); %return the ratio of noise
    
end

