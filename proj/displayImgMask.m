function maskdImgs = displayImgMask( img, masks, imgOutput )
%DISPLAYIMGMASK given an image and a vector os masks, displays all masked
%images
%   img is the w by h image being masked
%   masks is a m by w by h logical matrix where m is the number of masks.
%          masks can also be a w by h logical matrix, for single mask usage
%   imgOutput OPTIONAL if this is passed, the function will return all
%   clusters as images in a m by w by h mtrix. And it will NOT show the
%   results with imshow
%   For each of the m masks, apply this to img and display only the truue
%   values from the mask

    printImage = nargin > 2;
    
    if printImage
        maskdImgs = zeros(size(masks));
    end

    if size(size(masks),2) == 2
        nMasks = 1;
    else
        nMasks = size(masks,1);
    end
    
    if ~printImage
        subplot(1,nMasks+1,1);
        imshow(img);
    end
    
    for k=1:nMasks
       %get mask, supports only 1 masks as well
       if nMasks == 1
           mask = masks;
       else
           mask = squeeze(masks(k,:,:));
       end
       
       %apply it to the original img
       origImg = img;
       for i=1:size(mask,1);
           for j=1:size(mask,2)
               %output = img AND mask
               if ~mask(i,j)
                    origImg(i,j,1) = 0;
                    origImg(i,j,2) = 0;
                    origImg(i,j,3) = 0;
               end
           end
       end
       
       
       if ~printImage
           subplot(1,nMasks+1,1+k);
           imshow(origImg);
       else
           if k == 1
               maskdImgs = origImg;
           else
               maskdImgs = cat(1,maskdImgs,origImg);
           end
       end
       
    end

end

