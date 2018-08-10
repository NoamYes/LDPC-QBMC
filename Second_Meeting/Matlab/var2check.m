function [v2c_cell] = var2check( c2v_cell, v_adj, QM)

        %% var 
        
        v2c_cell = v_adj;
        V_tmp = init_v(c2v_cell, v_adj);
        
        for i = 1:length(v_adj)
            
            for j = 1:length(v_adj{i})
            
                 var_to_pass = V_tmp;
                 var_to_pass{i}(j) = QM;
                 v2c_cell{i}(j) = fv(var_to_pass{i}, QM);
                 var_to_pass = V_tmp;
                 
                
            end
            
        end
        
            
        
        
end


     function V = init_v(c2v_cell, v_adj)
     
        V = v_adj;
        for i = 1:length(v_adj)
            
            for j = 1:length(v_adj{i})
                V{i}(j)=c2v_cell{v_adj{i}(j)}(j);
            end
        end
     end
     

