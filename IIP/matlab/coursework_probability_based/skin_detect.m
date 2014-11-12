function skin_detect(filename)
    img = imread(filename);
    
    %sees training set and returns a probability density matrix
    pHist = process_test();
    
    %test image appears to be noisy (there are high values even after
    %applying median filter)
    %So we need to decide a limit... takes the median of all non-zero
    %values and multiply by 10
    limit = median(pHist(pHist~=0));
    
    %Now compares the image. Checks for each pixel what's the probability
    %of it being a skin pixel.
    mask = zeros(size(img,1),size(img,2),3);
    for i=1:size(img,1)
        for j=1:size(img,2)
            pSkin = isSkin(img(i,j,:), pHist);
            if(pSkin>limit)
                mask(i,j,1)=255;
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
    radius = round(size(img,1)*size(img,2)/30000);
    mask(:,:,1) = imdilate(mask(:,:,1), strel('diamond',radius) );
    mask(:,:,1) = imerode (mask(:,:,1), strel('diamond',radius) );
    
    
    subplot(1,2,1),imshow(mask);
    subplot(1,2,2),imshow(img);
end

function z=isSkin(pixel, pHist)
    z=pHist(pixel(1)+1, pixel(2)+1, pixel(3)+1);
end