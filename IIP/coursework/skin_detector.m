function [ mask ] = skin_detector( target , training)
%SKIN_DETECTOR Detects skin from the target image based on the training
%set (output by the prob_extractor() function)

    limit = 0;
    
    %convert to hsv
    hsv = rgb2hsv(target);
    
    %initialises the mask
    mask = zeros(size(target,1), size(target,2));
    
    hue = round(hsv(:,:,1)*360);
    sat = round(hsv(:,:,2)*100);
    
    hue = medfilt2(hue);
    sat = medfilt2(sat);
    
    %detect skin
    %for each pixel, decide if it's skin or not looking at the training set
    %pdf
    for i=1:size(target,1)
        for j=1:size(target,2)
            
            hueP = hue(i,j);
            
            satP = sat(i,j);
            
            prob = training(hueP+1,satP+1);
            if prob>limit
                mask(i,j) = 1;
            end
            
        end
    end
    
    mask = medfilt2(mask,[10 10]);

    radius = round(numel(mask)/30000);
    
    mask = imdilate(mask, strel('diamond',radius) );
    mask = imerode (mask, strel('diamond',radius) );

    mask = logical(mask);
    
end


