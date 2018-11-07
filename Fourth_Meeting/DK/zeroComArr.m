function [comArr] = zeroComArr(vec_len, vec_options)
    arr_len = nchoosek(vec_len + vec_options - 1, vec_options - 1);
    comArr = zeros(1, arr_len);
end

