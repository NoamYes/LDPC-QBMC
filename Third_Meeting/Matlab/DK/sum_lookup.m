function [out_vec] = sum_lookup(H_t, var_vec, dc, looktable, dividetable, hv_vec)
    
    [~, size_c] = size(H_t);
    out_vec = zeros(1, size_c) + 1;
    [row, ~] = find(H_t); %find the location of not 0 in H_t
    for idx = 1:size_c
        for jdx = 1:dc - 1
            out_vec(idx) = looktable(1, ...
                out_vec(idx), ...
                dividetable(H_t(row((idx-1)*(dc-1)+jdx),idx),hv_vec(idx)), ... 
                var_vec(row((idx-1)*(dc-1)+jdx)));
        end
    end

end

