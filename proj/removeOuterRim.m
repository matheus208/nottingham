function res = removeOuterRim(im, radius)
    res = im;
    [m, n, ~] = size(im);
 
    centre = [m/2 n/2];
    
    
    for i=1:m
        for j=1:n
            if ~inCircle(i,j,centre,radius)
                res(i,j,:) = 0;
            end
        end
    end
end

function bool = inCircle(x,y, c, r)
    
    bool = sqrt( (x-c(1))^2 + (y-c(2))^2 );
    bool = bool < r;
end