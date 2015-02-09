function [ whiteImg ] = identifyWhiteCluster( img, masks )
%IDENTIFYVEGCLUSTER Gives a mask of the vegetation pixels in a image given
%the clustered masks and the image
%  img is a w by h hsv image
%  masks is a m by w by h matrix of clusters, where m is the amount of
%  clusters

    WhiteSat = 0/255;
    
    img = rgb2hsv(img);
    numOfMasks = size(masks,1);
    sat = squeeze(img(:,:,1));
    
    minError = 0;
    minErrorIdx = 0;
    
    %For each mask
    for i=1:numOfMasks
        %Retrieve the mask from the masks matrix
        mask=squeeze(masks(i,:,:));
        %Extract the hue values applicable
        maskedImg=sat(mask==1);
        %Calculates the error by comparing it to the standard "green hue"
        %and squaring
        diff = (maskedImg - ones(size(maskedImg,1), size(maskedImg,2)) * WhiteSat ).^2;
        error = sum(diff(:));
        %Finds the index of the mask with minimum error
        if i==1 || error < minError
            minError = error;
            minErrorIdx = i;
        end
    end

    whiteImg = squeeze(masks(minErrorIdx,:,:));

end

