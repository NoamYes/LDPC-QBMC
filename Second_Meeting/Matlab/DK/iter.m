function [output] = iter(H, vec, QM, iter_len)

    [row, ~] = size(H);
    Mat = repmat(vec,[row,1]); %initiate a matrix like H with all the repeat
    %of the vector vec
    old_var = vec; %initate the var vector
    for i = 1:iter_len
        Mat = var2check(Mat, H, old_var);
        var = check2var(Mat, QM);
        if isequal(var, old_var) || ~any(var) %if var didn't change or it 
            % the 0 vector, end the iteration
            break;
        end
        old_var = var;
    end
    
    new_noise = sum(var(:) == QM);
    output = new_noise/length(var); %return the ratio of noise
    
end

