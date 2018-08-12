function [c2v_cell] = check2var(c2v_last, v2c_cell, c_adj,QM, v_adj)


c2v_cell = c2v_last;
Ctmp = init_c(v2c_cell, c_adj, v_adj);

parfor i = 1:length(c_adj)
    
    for j = 1:length(c_adj{i})
        
        check_to_pass = Ctmp;
        check_to_pass{i}(j) = 0;
        current_node = Ctmp{i}(j);
        
        %% fc is activated to decode the var from parity check
        c2v_cell{i}(j) = fc(check_to_pass{i}, QM, current_node);
        check_to_pass = Ctmp;
        
    end
    
end

end


% this function transparform of the v2c_cell to c2v_cell, i.e - inverse the edges of graph 
% isn't an ideal way one would choose to represent graph to work with, but useful in time in this case

function C = init_c(v2c_cell, c_adj, v_adj)

C = c_adj;
parfor i = 1:length(c_adj)
    
    for j = 1:length(c_adj{i})
        idx = find(v_adj{c_adj{i}(j)} == i);
        if (~isempty(idx))
            C{i}(j)=v2c_cell{c_adj{i}(j)}(idx);
        end
    end
end
end
