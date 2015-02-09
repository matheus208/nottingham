function idVeg( image )
%IDVEG Given an image, outputs its vegetation information
%   

    [masks, sumd] = km_hsv(image, 3, 'sqEuclidean', 3);
    
    [vegCluster, idx] = identifyVegCluster(image, masks);
    whiteCluster = identifyWhiteCluster(image, masks);
    
    veg = displayImgMask(image, vegCluster, 1);
    white = displayImgMask(image, whiteCluster, 1);
    
    subplot(1,2,1);
    imshow(image);
    
    subplot(1,2,2);
    imshow(veg);
    title(sprintf('%.2f%%',100*nnz(vegCluster) / (numel(vegCluster)-nnz(whiteCluster))));
    

end

