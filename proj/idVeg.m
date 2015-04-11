function idVeg( image )
%IDVEG Given an image, outputs its vegetation information
%   

    [masks] = km_hsv(image, 10, 'sqEuclidean', 4);
    
    [vegCluster, ~] = identifyVegCluster(image, masks);
    whiteCluster = identifyWhiteCluster(image, masks);
    
    %Median filter
    %vegCluster = medfilt2(vegCluster, [30 30]);
    
    %Morphological Filter
    %vegCluster = imerode (vegCluster, strel('diamond',10) );
    %vegCluster = imdilate(vegCluster, strel('diamond',10) );
    
    veg = displayImgMask(image, vegCluster, 1);
    
    subplot(1,2,1);
    imshow(image);
    
    subplot(1,2,2);
    imshow(veg);
    title(sprintf('%.2f%%',100*nnz(vegCluster) / (numel(vegCluster)-nnz(whiteCluster))));
    
    %Try writing artificial data! Arguments for or against it
    
    %Try to look for some other papers that do something similar and
    %already have a model
    
    %Mean shift
    
    %Implement KMeans
    
    %Look at IIP lab about edge detection to try to begin with crusting
    %anlysis

end

