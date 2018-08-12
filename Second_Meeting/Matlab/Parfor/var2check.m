function [v2c_cell] = var2check(v2c_last, c2v_cell, v_adj, QM, c_adj)

%% var

v2c_cell = v2c_last;
V_tmp = init_v(c2v_cell, v_adj, c_adj);

parfor i = 1:length(v_adj)
    
    for j = 1:length(v_adj{i})
        
        var_to_pass = V_tmp;
        var_to_pass{i}(j) = V_tmp{i}(j);
        current_node = v2c_last{i}(j);
        
        %% fv is activated to transmit var based on last check2var
        v2c_cell{i}(j) = fv(var_to_pass{i}, QM, current_node);
        var_to_pass = V_tmp;
        
    end
    
end

end


% this function transforms of the c2v_cell to v2c_cell, i.e - inverse the edges of graph 
% isn't an ideal way one would choose to represent graph to work with, but useful in time in this case

function V = init_v(c2v_cell, v_adj, c_adj)

V = v_adj;
parfor i = 1:length(v_adj)
    
    for j = 1:length(v_adj{i})
        idx = find(c_adj{v_adj{i}(j)} == i);
        if (~isempty(idx))
            V{i}(j)=c2v_cell{v_adj{i}(j)}(idx);
        end
    end
end
end


