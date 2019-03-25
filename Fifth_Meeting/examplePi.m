dc = 6;
q = 64;
sum = 0;
for j = 1:(log2(q)+1)
    sum = sum + nchoosek(dc-3+j,j-1);
end
disp(1-(sum/(log2(q)+1)^(dc-1)))
