%% this function gets the H matrix and the noise vec as well as thedoc QM and
% the length of the iterations. it then runs iter_len times the netword
% iterations (with optimization) and return the noise ratio in the end.

function [NoiseRatio] = iter(H, vec, q, iter_len, dc, v2c_s, c2v_s, lookMat, divideMat)

%     [row, col] = size(H);
%     Mat_t = repmat(vec.',[1,row]); %initiate a matrix like H with all the repeat
%     %of the vector vec.' (for performance)
    old_var = vec; %initate the var vector
    H_t = H.';
    init_v2c = vec(v2c_s.cols);
    c2v = check2var(H,init_v2c, v2c_s, c2v_s, lookMat, divideMat);
%     QM_var = zeros(1,col) + QM; %create a QM var vec with length n

    
    for i = 1:iter_len
        v2c = var2check(H,c2v, v2c_s, c2v_s, q);
        c2v = check2var(H, v2c, v2c_s, c2v_s, lookMat, divideMat);
        decoded = min(v2c, [], 2);
         if isequal(decoded, old_var) || ~any(decoded) %if var didn't change or it 
             % the 0 vector, end the iteration
             break;
         end
%         old_var = var;
    end
    
    decoded = min(v2c, [], 2);
    end_noise = sum(decoded(:));
    NoiseRatio = end_noise/sum(old_var); %return the ratio of noise
    
end

