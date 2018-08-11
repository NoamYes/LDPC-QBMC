function [output] = checkNoise(H, vec, iterLen, QM)
    
    old_noise = sum(vec(:) == QM);
    if old_noise == 0 %don't devide by zero
        output = 0;
    else
        new_vec = iter(H,vec,QM,iterLen);
        new_noise = sum(new_vec(:) == QM); %how many QM are left
        output = new_noise/length(vec); %return the ratio of noise
    end
end