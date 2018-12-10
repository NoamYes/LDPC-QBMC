%% 
% input - vec: the commArr of length dc - 1 and has values form [1,t]
%         vec_options: t
function [idx] = idxComArr(vec, vec_options)
    len_vec = numel(vec);
    hist_vec = zeros(1, vec_options);
    for i=1:len_vec
        hist_vec(vec(i)) = hist_vec(vec(i)) + 1;
    end
    idx = 0;
    for i=0:numel(hist_vec)-1
        idx = idx + hist_vec(i+1)*vec_options^i;
    end
end

