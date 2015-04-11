function [ output_args ] = findCrust( img )
    
    img = impyramid(img, 'reduce');
    img = impyramid(img, 'reduce');
    img = impyramid(img, 'reduce');
    
    %Calculate the radius of the relevant sample
    radius =  (0.95 * size(img,2))/2;
    im = removeOuterRim(img, radius);

    %sharpen image
    sharp = imfilter(im, fspecial('unsharp'));
    sharp = imfilter(sharp, fspecial('unsharp'));
    
    
    %convert to grayscale
    bw = rgb2gray(sharp);
    
    %reduce image
    red = bw;
   % red = impyramid(bw, 'reduce');
   % red = impyramid(red, 'reduce');
    
    %detect edge
    edg = edge(red, 'canny', .1, 6); %values tried for test3 img
    
    %rescale
   % big = imresize(edg, 4.0);
    big = edg;
    
    %Removes the rim again (or it will be detected as a border)
    lines = removeOuterRim(big, 0.99*radius);
    
    %Get rid of thick lines
    skel = bwmorph(lines,'skel',Inf);
    %Removes small componenets 
    cleanedUp = bwareaopen(skel, round(numel(skel) * 0.5/100), 8);
    %Removes standalone ("spur") pixels
    spur = bwmorph(cleanedUp, 'spur',5);
    
    %Finds the endpoints
    ep = bwmorph(spur,'endpoints');
    
    %Calculates the gradient of the image to use on completeLines
    gMag = imfilter(rgb2gray(img), fspecial('sobel'));
    
    %reduce everything to save memory!
    conn = completeLines(ep,spur, Inf, gMag);
    
    mask = 255*uint8(cat(3, conn,cat(3, spur,spur)));
    
    
    
    alpha = .5;
    imshow(alpha*im + (1-alpha)*mask);
    figure, imshow(mask);
    figure, imshow(im);
    
    output_args = conn;
    
    
    
    area = bwarea(imfill(255*conn, 'holes'));
%snakes wouldnt work because we would have to initialise it on each crust
%(which we dont know)
    
    
end

function im = completeLines(endPoints, im, distThresh, gMag)
    [x, y] = find(endPoints);
   
    count = 0;
    k = [1,1,1;1,0,1;1,1,1];
    countEP = conv2(uint8(endPoints),k,'same');
    
    for i=1:length(x)
        
        %First, let's see if this isn't a false-positive
        %Check if there are no other endpoints around it
        %if there are, then it doesnt need connectionto be connected
        if(countEP(x(i),y(i))>0) 
            continue; 
        end;
        
        
        minDist=Inf;
        minDistIdx = 0;
        %Find the closest point to i
        for j=i:length(x)
            if i==j 
                continue; 
            end;
            dist = pointDist(x(i),y(i),x(j),y(j));
            if dist < minDist
                minDist = dist;
                minDistIdx = j;
            end
        end
        
        if minDist < distThresh && minDist > 1
            %Now that we got the closest point, draw a line
            fprintf('i=%d, j=%d\n',i,j);
            memory;
            im = drawLine(im, gMag, x(i), y(i), x(minDistIdx), y(minDistIdx));
            count = count+1;
        end
        
    end
    
    fprintf('%d lines drawn\n',count);
end

function d = pointDist(x1, y1, x2, y2)

    dx = (x1 - x2);
    dy = (y1 - y2);
    
    d = sqrt(dx^2+dy^2);
    
end

function img = drawLine(img, gradient, y1, x1, y2, x2)
    
%    if x1<x2
%        rangeX = x1:x2;
%    else 
%        rangeX = x2:x1;
%    end
%    
%    if y1<y2
%        rangeY = y1:y2;
%    else
%        rangeY = y2:y1;
%    end

    %Get the relevant grid only & convert it to an adjacency matrix
%    grid = gradient(rangeX, rangeY);
%    adj = mat2adj(grid);

%    [~, route] = dijkstra(adj,1,length(adj)); %dijkstra(adj,1,284050)
    
    %Route is a vector with the indices that must be painted
%    img(route) = 1;

    % distances according to both axes
    xn = abs(x2-x1);
    yn = abs(y2-y1);

    % interpolate against axis with greater distance between points;
    % this guarantees statement in the under the first point!
    if (xn > yn)
        xc = x1 : sign(x2-x1) : x2;
        yc = round( interp1([x1 x2], [y1 y2], xc, 'linear') );
    else
        yc = y1 : sign(y2-y1) : y2;
        xc = round( interp1([y1 y2], [x1 x2], yc, 'linear') );
    end

    % 2-D indexes of line are saved in (xc, yc), and
    % 1-D indexes are calculated here:
    ind = sub2ind( size(img), yc, xc );

    % draw line on the image (change value of '255' to one that you need)
    img(ind) = 255;

end

