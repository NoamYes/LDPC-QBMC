%% lookMat - calcs the lookup matrix for a given q
% lookMat is a 4dim array of size (q-1,log2(q),q-1,log2(q)) = (i,j+1,k,h+1)
% it takes 2 constants [i and k] and 2 "sets" in the form of integers (i.e
% the set (0) is 0, (0,1) is 1, (0,1,2,3) is 3 and so on) [j+1 and h+1, the
% reason for +1 is since 0 is a valid number but matlab matrix starts at
% 1. 
% so it returns - 

function [lookMat] = look_up(q, subCell) 

    logq = log2(q);
    subLen = numel(subCell);
    lookMat = zeros(q-1, subLen, q-1, subLen);
    for i = 1:q-1 %run on all the consts
        for j = 1:subLen %run on all the sets
            for k = 1:q-1 %run on all the consts
                for h = 1:subLen %run on all the sets
                    res = [];
                    for m = subCell{j} %run on all the options for set j
                        for n = subCell{h} %run on all the options for set h
                            res = [res, gf(i, logq) * gf(m, logq) + ...
                                gf(k, logq) * gf(n, logq)];
                            % calc all the possible solutions for the
                            % equation.
                        end
                    end
                    group = unique(res.x);
                    isSub = cellfun(@(x)isequal(x,group),subCell);
                    loc = find(isSub);
                    lookMat(i,j,k,h) = loc;
                    % find
                    % how many different results res has and remove 1 to get
                    % the correct format for the int "set"
                end
            end
        end
    end              
end
