function [out_set] = five2one(subArr, constArr, dc, looktable, dividetable)
%FIVE2ONE Summary of this function goes here
%   Detailed explanation goes here
    out_set = 1;
    for jdx = 1:dc - 1 %run on all the other variables (v_i) in the row
            out_set = looktable(1, ...
                out_set, ...
                dividetable(constArr(jdx) ,constArr(dc)), ... 
                subArr(jdx));
            %this lookup table does: tmp = 1*tmp + h_jdx/h_idx * v_jdx
            %where tmp starts as the 'zero' set and then changes values
            %iterativly.
    end
end

