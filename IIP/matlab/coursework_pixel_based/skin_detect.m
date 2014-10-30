function y=skin_detect(img)
    %we have an rgb image, let's iterate over the pixels and mark the ones
    %that have hue similar to skin
    
    %reduce noise
    %img = imfilter(img, fspecial('average',10));
    
    
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
    
    y=mask;
end

function y=isSkinPixel(pixel)
    y=0;
    %if we have a matching hue
    %if(output(i,j,1) > 6/360 && output(i,j,1) < 38/360)
     if(pixel(1) > 6/360 && pixel(1) < 38/360)
        %and matching saturation
        if(pixel(2) > 40/255 && pixel(2) < 150/255)
           %set to red
            y=1;
        end
     end
end
    