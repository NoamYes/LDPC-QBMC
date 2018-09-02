%% this function gets the H matrix and the noise vec as well as thedoc QM and
% the length of the iterations. it then runs iter_len times the netword
% iterations (with optimization) and return the noise ratio in the end.

function [NoiseRatio] = iter(H, vec, iter_len, dc, looktable, dividetable)

    [row, ~] = size(H);
    Mat_t = repmat(vec.',[1,row]); %initiate a matrix like H with all the repeat
    %of the vector vec.' (for performance)
    old_var = vec; %initate the var vector
    H_t = H.';
    
    start_noise = sum(old_var);
    if start_noise == 0
        NoiseRatio = 0;
    else
        for i = 1:iter_len
            Mat_t = check2var(Mat_t, H_t, old_var, dc, looktable, dividetable);
            var = var2check(Mat_t);
            if isequal(var, old_var) || ~any(var) %if var didn't change or it 
                % the 0 vector, end the iteration
                break;
            end
            old_var = var;
        end

%         end_noise = sum(var);
%         NoiseRatio = end_noise/start_noise; %return the ratio of noise
        end_noise = numel(find(var));
        NoiseRatio = end_noise/numel(var);
    end
    
end

