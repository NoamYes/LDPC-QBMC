%% this function gets the H matrix and the noise vec as well as thedoc QM and
% the length of the iterations. it then runs iter_len times the netword
% iterations (with optimization) and return the noise ratio in the end.

function [NoiseRatio] = iter(H, vec, QM, iter_len)

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
    
    end_noise = sum(var(:) == QM);
    NoiseRatio = end_noise/length(var); %return the ratio of noise
    
end

