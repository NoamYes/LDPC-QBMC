function [ decoded ] = deCell( cellVec, QM )

% cellVec is final var to check vector which we should take
% from the decoded
decoded = zeros(length(cellVec),1);
for i = 1:length(cellVec)
    
    for j = 1:length(cellVec)
        
        if isempty(find(cellVec{i} ~= QM, 1))
            
            decoded(i) = QM;
        else
            
            not_QM = cellVec{i}(cellVec{i} ~= QM);
            decoded(i) = not_QM(1);
        end
        
    end
end

end

