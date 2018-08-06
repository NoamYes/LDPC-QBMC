function [out_vec] = iter(H, vec, QM)

    out_vec = vec;
    change_vec = find(~(H*vec.'-QM)); %find the locations of 'lonely' question marks
    for i = 1:length(change_vec)
       
        tmp = ~(H(change_vec(i),:).*vec-QM); %find the location of the question mark in the original vector
        out_vec(tmp) = 0; %cheating here, by updating it to be 0 and not XOR of all the rest (since they are allways 0)

        %% not cheating:
%             xor_vec = logical(H(change_vec(i),:));
%             xor_vec(tmp) = 0;
%             out_vec(tmp) = mod(sum(vec(xor_vec)),2);

        %% Trying generic method (with 1's optional)

    %     QM_indices = H.*repmat(out_vec == QM, length(H(:,end)),1); %% find QM in rows of H overlap with the vec , place 1 instead of QM
    %     QM_rows = sum(QM_indices, 2); %% sum up the number of QM in each row
    %     ones_rows = sum(H, 2); %% sum up the number of '1' in each row
    %     rows_decode_idx = find(QM_rows == 1); %% helpful equations are the rows with 1 QM that we can decode
    %     helpful_checks = H(rows_decode_idx,:);
    %     if (isempty(helpful_checks))
    %         break;
    %     end
    %     res_checks = mod(helpful_checks*(out_vec.')-QM,2); %% now the result of the scalar multiplication minus QM modulo 2 is the xor between the other bits
    %     out_vec(rows_decode_idx,helpful_checks == QM) = res_checks;
    % 
    %     

    end

end