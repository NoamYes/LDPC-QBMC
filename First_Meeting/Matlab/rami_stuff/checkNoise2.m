function [output] = checkNoise2(H, vec, iterLen, QM)
    
    disp('old vector is: '); disp(vec);
    old_noise = sum(vec(:) == QM);
    if old_noise == 0 %don't devide by zero
        output = 0;
    else
        old_tmp = vec;
        for i = 1:iterLen %run iterLen iterations of the function iter
            tmp = iter2(H,old_tmp,QM);
            %% added this for optimization for iter
            if tmp == old_tmp
                break;
            end
            old_tmp = tmp;
        end
        disp('new vector is: '); disp(tmp);
        disp('H*vec = '); disp(mod(H*tmp.',2))
        new_noise = sum(tmp(:) == QM);
        output = new_noise/length(vec); %return the ratio of noise

    end
end