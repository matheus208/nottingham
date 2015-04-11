function adj = mat2adj(mat)

    [m,n]=size(mat);
    adj = sparse(m*n, m*n);
    for j=1:n
        for i=1:m
            notFirstRow = i~=1;
            notLastRow  = i~=m;
            notFirstCol = j~=1;
            notLastCol  = j~=n;
            
            %North
            if notFirstRow
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i-1,j))    = mat(i-1,j);
            end
            
            %Northeast
            if notFirstRow && notLastCol
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i-1,j+1))    = mat(i-1,j+1);
            end
            
            %East
            if notLastCol
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i,j+1))    = mat(i,j+1);
            end
            
            %Southeast
            if notLastCol && notLastRow
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i+1,j+1))    = mat(i+1,j+1);
            end
            
            %South
            if notLastRow
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i+1,j))    = mat(i+1,j);
            end
            
            %Southwest
            if notLastRow && notFirstCol
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i+1,j-1))    = mat(i+1,j-1);
            end
            
            %West
            if notFirstCol
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i,j-1))    = mat(i,j-1);
            end
            
            %Northwest
            if notFirstRow && notFirstCol
                adj(sub2ind(size(mat),i,j) , ...
                    sub2ind(size(mat),i-1,j-1))    = mat(i-1,j-1);
            end
            
        end
    end
  
end