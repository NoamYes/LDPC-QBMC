for idx = 1:numel(e1_vec) %run on epsilon values from 0 to 1 in increments of inc
    e1 = e1_vec(idx);
    for jdx = 1:numel(e2_vec)
        e2 = e2_vec(jdx);
        parfor pdx = 1:numel(e3_vec)
            e3 = e3_vec(pdx);
            if e1 + e2 + e3> 1
                mean_mat(idx,jdx, pdx) = 1;
            else
%                 e_vec = [(1-e1-e2-e3) e1 e2 e3];
%                 [Z] = EquationDecoding(e_vec, PiMat,  IiMat, q, dc, dv);
%                 mean_mat(idx,jdx, pdx) = 1 - Z(1);
            end
        end
    end
    disp(round(idx/numel(e1_vec)*100,1)+"% done in "+round(toc,1)+" (sec)");
end