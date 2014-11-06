function y=skin_detect(img)
    %we have an rgb image, let's iterate over the pixels and mark the ones
    %that have hue similar to skin
    
    %reduce noise
    img = imfilter(img, fspecial('average',5));
    
    
    %convert the image to hsv
    hsv = rgb2hsv(img);
    
    %copy the output
    output = hsv;
    
    mask = zeros(size(output,1),size(output,2),3);
    
    %iterate over the pixels in the image
    for i=1:size(output,1)
        for j=1:size(output,2)
            if(isSkinPixel(output(i,j,:)))
                mask(i,j,1)=255;
            end
                
        end
    end
    
    %here we have a good segmentation, but there`s still noise in the image
    %like background or clothes being detected as skin.
    %let`s find the connected components of the image and apply a
    %threashold on their areas, so we disregards small patches of skin-like
    %pixels.
    
    
    %find the connected componenets
    y=mask;
end

function y=isSkinPixel(pixel)
    y=0;
    
    
    %min_hue = 6;
    %max_hue = 38;    
    min_hue = 6;
    max_hue = 27;
    
    %if we have a matching hue
     if(pixel(1) > min_hue/360 && pixel(1) < max_hue/360)
        %and matching saturation
        %if(pixel(2) > 40/255 && pixel(2) < 150/255)
           %set to red
            y=1;
        %end
     end
end
    