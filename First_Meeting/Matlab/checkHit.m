function [loutput] = checkHit(H, vec, iterLen, QM)

tmp = vec;
for i = 1:iterLen %run iterLen iterations of the function iter
    tmp = iter(H,tmp,QM);
end
loutput = sum(tmp) == 0; %check if after iterLen iterations we get back to 0 vec

end

