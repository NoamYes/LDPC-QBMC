%% this function gets the H matrix and the noise vec as well as thedoc QM and
% the length of the iterations. it then runs iter_len times the netword
% iterations (with optimization) and return the noise ratio in the end.

function [NoiseRatio] = iter(H, vec, q, iter_len, dc, v2c_s, c2v_s, lookMat, divideMat)


    old_var = vec; %initate the var vector
    H_t = H.';
    init_c2v = vec(c2v_s.rows);
    mat = zeros(size(H));
    mat(c2v_s.idxs) = init_c2v;
    init_v2c = mat(v2c_s.idxs);
    c2v = check2var(H,init_v2c, v2c_s, c2v_s, lookMat, divideMat);
    
    for i = 1:iter_len
        v2c = var2check(H,c2v, v2c_s, c2v_s, q, init_v2c);
        c2v = check2var(H, v2c, v2c_s, c2v_s, lookMat, divideMat);
        decoded = min(v2c, [], 2);
         if isequal(decoded, old_var) || ~any(decoded) %if var didn't change or it 
             % the 0 vector, end the iteration
             break;
         end
    end
    
    decoded = min(v2c, [], 2);
%     end_noise = sum(decoded(:));
%     NoiseRatio = end_noise/sum(old_var); %return the ratio of noise
    end_noise = sum(decoded(:) ~= 0);
    NoiseRatio = end_noise/length(old_var); %return the ratio of noise

    
end

