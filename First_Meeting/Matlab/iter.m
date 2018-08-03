function [out_vec] = iter(H, vec, QM)

out_vec = vec;
change_vec = find(~(H*vec.'-QM)); %find the locations of 'lonely' question marks
for i = 1:length(change_vec)
    tmp = ~(H(change_vec(i),:).*vec-QM); %find the location of the question mark in the original vector
    out_vec(tmp) = 0; %cheating here, by updating it to be 0 and not XOR of all the rest (since they are allways 0)
    %% not cheating:
    %xor_vec = logical(H(change_vec(i),:));
    %xor_vec(tmp) = 0;
    %out_vec(tmp) = xor(vec(xor_vec)); %don't know how to do this - xor on
    %all the items in the array
end

end