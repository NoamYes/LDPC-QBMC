function [output] = checkNoise(H, vec, iterLen, QM)

    old_noise = sum(vec(:) == QM);
    if old_noise == 0 %don't devide by zero
        output = 0;
    else
        old_tmp = vec;
        for i = 1:iterLen %run iterLen iterations of the function iter
        tmp = iter(H,old_tmp,QM);
            %% added this for optimization for iter
            if tmp == old_tmp
                break;
            end
            old_tmp = tmp;
        end

        new_noise = sum(tmp(:) == QM);
        output = new_noise/length(vec); %return the ratio of noise

    end
end