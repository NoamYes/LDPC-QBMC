function [out_vec] = sum_lookup(H_t, var_vec, dc, looktable, dividetable, hv_vec)
    %
    % USE IND2SUB
    %
    [~, size_c] = size(H_t);
    out_vec = zeros(1, size_c) + 1;  %create a 'zero' vector 
    [row, ~] = find(H_t); %find the location of not 0 in H_t
    for idx = 1:size_c %run on all the cols
        for jdx = 1:dc - 1 %run on all the other variables (v_i) in the row
            out_vec(idx) = looktable(1, ...
                out_vec(idx), ...
                dividetable(H_t(row((idx-1)*(dc-1)+jdx),idx),hv_vec(idx)), ... 
                var_vec(row((idx-1)*(dc-1)+jdx)));
            %this lookup table does: tmp = 1*tmp + h_jdx/h_idx * v_jdx
            %where tmp starts as the 'zero' set and then changes values
            %iterativly.
        end
        %it sums all the possible sets that v_idx can be.
    end

end

