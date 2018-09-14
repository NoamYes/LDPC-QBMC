%% lookMat - calcs the lookup matrix for a given q
% lookMat is a 4dim array of size (q-1,log2(q),q-1,log2(q)) = (i,j+1,k,h+1)
% it takes 2 constants [i and k] and 2 "sets" in the form of integers (i.e
% the set (0) is 0, (0,1) is 1, (0,1,2,3) is 3 and so on) [j+1 and h+1, the
% reason for +1 is since 0 is a valid number but matlab matrix starts at
% 1. 
% so it returns - 

function [subCell] = subset(q) 
    logq = log2(q);
    subCell = {};
    for t =0:logq
        subCell{t+1} = uint32(0:2^t-1);
    end
    sub_idx = logq+1;
    for i = 1:q-1 %run on all the consts
        for j = 0:logq %run on all the sets
            for k = 1:q-1 %run on all the consts
                for h = 0:logq %run on all the sets
                    res = [];
                    for m = 0:2^j-1 %run on all the options for set j
                        for n = 0:2^h-1 %run on all the options for set h
                            res = [res, gf(i, logq) * gf(m, logq) + ...
                                gf(k, logq) * gf(n, logq)];
                            % calc all the possible solutions for the
                            % equation.
                        end
                    end
                    group = unique(res.x);
                    isSub = cellfun(@(x)isequal(x,group),subCell);
                    if isempty(find(isSub, 1)) %if group is not in subCell
                        sub_idx = sub_idx + 1;
                        subCell{sub_idx} = group;
                    end
                end
            end
        end
    end              
end