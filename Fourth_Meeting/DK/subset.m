%% subset - calcs the relevant subgroups of a given q.
% subCell is a cell array and every item in it is an int array
% that represents a group that is apart of the subgroup.

function [subCell] = subset(q) 
    logq = log2(q);
    subCell = {};
    for t =0:logq
        subCell{t+1} = uint32(0:2^t-1); %find the "trivial" sets
    end
    sub_idx = logq+1;
    for i = 1:q-1 %run on all the consts
        for j = 1:logq+1 %run on all the trivial sets
            for k = 1:q-1 %run on all the consts
                for h = 1:logq+1 %run on all the trivial sets
                    res = [];
                    for m = subCell{j} %run on all the options for set j
                        for n = subCell{h} %run on all the options for set h
                            res = [res, gf(i, logq) * gf(m, logq) + ...
                                gf(k, logq) * gf(n, logq)];
                            % calc all the possible solutions for the
                            % equation.
                        end
                    end
                    group = unique(res.x); % find the unique values
                    isSub = cellfun(@(x)isequal(x,group),subCell);
                    if isempty(find(isSub, 1)) %if group is not in subCell
                        sub_idx = sub_idx + 1;
                        subCell{sub_idx} = group; %add it to subCell
                    end
                end
            end
        end
    end              
end