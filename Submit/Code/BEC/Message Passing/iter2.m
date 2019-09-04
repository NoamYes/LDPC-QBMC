%% this function gets the H matrix and the noise vec as well as thedoc QM and
% the length of the iterations. it then runs iter_len times the netword
% iterations (with optimization) and return the noise ratio in the end.

function [NoiseRatio] = iter2(H, vec, QM, iter_len, dc)

    [row, col] = size(H);
    Mat_t = repmat(vec.',[1,row]); %initiate a matrix like H with all the repeat
    %of the vector vec.' (for performance)
    old_var = vec; %initate the var vector
    H_t = H.';
   
    QM_var = zeros(1,col) + QM; %create a QM var vec with length n

    
    for i = 1:iter_len
        Mat_t = var2check2(Mat_t, H_t, old_var, dc);
        var = check2var2(Mat_t, QM_var);
        if isequal(var, old_var) || ~any(var) %if var didn't change or it 
            % the 0 vector, end the iteration
            break;
        end
        old_var = var;
    end
    
    end_noise = sum(var(:) == QM);
    NoiseRatio = end_noise/length(var); %return the ratio of noise
    
end

