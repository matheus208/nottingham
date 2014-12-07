function skin_detect_hsv(filename)
    img = imread(filename);
    hsv = rgb2hsv(img);
    
    %process training set and return a PDF
    pHist = process_test_hsv();
    
    %test image appears to be noisy (there are high values even after
    %applying median filter)
    %So we need to decide a limit... takes the median of all non-zero
    %values and multiply by 10
    %limit = median(pHist(pHist~=0))*30;
    limit = 1/10000;
    
    %Now compares the image. Checks for each pixel what's the probability
    %of it being a skin pixel.
    mask = zeros(size(hsv,1),size(hsv,2));
    for i=1:size(hsv,1)
        for j=1:size(hsv,2)
            pSkin = isSkin(hsv(i,j,:), pHist);
            if(pSkin>limit)
                mask(i,j)=1;
            end
        end
    end
    
    %Now we have a mask, but it probably is very noisy.
    %So let's apply a dilation/erosion technique so we get rid of small
    %noise that might appear on non-skin pixels.
    %Since small values for the structuring element might not be effective,
    %large values might destroy the mask on smalled images. So let's
    %calculate the size of the structuring element as being a fraction of
    %the image's dimension (larger images should have larger structuring
    %elements)
    radius = round(size(hsv,1)*size(hsv,2)/100000);
    
    %mask = imdilate(mask, strel('diamond',radius) );
    %mask = imerode (mask, strel('diamond',radius) );
    
    
    
    
    subplot(1,2,1),imshow(mask);
    subplot(1,2,2),imshow(img);
end

function z=isSkin(pixel, pHist)
    hue = uint8(pixel(1)*360);
    sat = uint8(pixel(2)*100);
    bins = size(pHist,1)-1;
    
    hueBin = 1 + round(hue*bins/360);
    satBin = 1 + round(sat*bins/100);
            
    z=pHist(hueBin, satBin);
end