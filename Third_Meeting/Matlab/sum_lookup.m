function [out_vec] = sum_lookup(looktable, H_t, var_vec, dc)
    
    [~, size_c] = size(H_t);
    out_vec = zeros(1, size_c);
    [row, ~] = find(H_t); %find the location of not 0 in H_t
    for idx = 1:size_c
        for jdx = 1:dc - 1
            out_vec(idx) = looktable(1, 1+log2(1+out_vec(idx)), H_t(row((idx-1)*(dc-1)+jdx),idx) ...
               , 1+log2(1+var_vec(row((idx-1)*(dc-1)+jdx))));
        end
    end
end

