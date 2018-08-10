function [c2v_cell] = check2var(v2c_cell, c_adj,QM)

        %% check
        
        c2v_cell = c_adj;
        Ctmp = init_c(v2c_cell, c_adj);
        
        for i = 1:length(c_adj)
            
            for j = 1:length(c_adj{i})
            
                
                check_to_pass = Ctmp;
                check_to_pass{i}(j) = 0;
                c2v_cell{i}(j) = fc(check_to_pass{i}, QM);
                check_to_pass = Ctmp;
                
%                 var_to_pass = v2c_cell;
%                 var_to_pass{c_adj{i}(j),:} = 0;

                
            end
            
        end
   

    
end

     function C = init_c(v2c_cell, c_adj)
     
        C = c_adj;
        for i = 1:length(c_adj)
            
            for j = 1:length(c_adj{i})
                C{i}(j)=v2c_cell{c_adj{i}(j)}(1);
            end
        end
     end
     