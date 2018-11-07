t = 5;
dc = 6;

comArr = zeroComArr(dc, t);

vec = [1 2 3 3 1 1];
comArr(idxComArr(vec ,t)) = -1;
vec2 = [1 1 5 2 1 3];
disp(comArr(idxComArr(vec2 ,t)))