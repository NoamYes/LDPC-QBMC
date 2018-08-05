function [output] = checkHit(H, vec, iterLen, QM)

old_tmp = vec;
for i = 1:iterLen %run iterLen iterations of the function iter
    tmp = iter(H,old_tmp,QM);
    if tmp == old_tmp %added this for optimization
        break;
    end
    old_tmp = tmp;
end
% loutput = sum(tmp) == 0; %check if after iterLen iterations we get back to 0 vec

output = sum(tmp~=0)/length(tmp); % return the ratio of erasures after decoding

end
%Dore is here
