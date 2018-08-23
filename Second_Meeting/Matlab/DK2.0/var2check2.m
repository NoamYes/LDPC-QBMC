function [Mat] = var2check2(i_Mat, H, var, dc)
    Mat = i_Mat.';
    one_loc = find(~(H.' - 1)); %find the location of ones in H.'
    for i = 1:dc
        dc_loc = one_loc(i:dc:end); %get the one_loc in i mod dv locations
        tmp_Mat = H.';
        tmp_Mat(dc_loc) = 0;
        mat_row = ~(tmp_Mat.' * var.');  %find the location of zeros in tmp_Mat * var
        Mat(dc_loc(mat_row)) = 0;
    end
    Mat = Mat.';
end

