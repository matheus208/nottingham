function displayImgMask( img, masks )
%DISPLAYIMGMASK Summary of this function goes here
%   Detailed explanation goes here

    nMasks = size(masks,1);
    
    subplot(1,nMasks+1,1);
    imshow(img);
    
    for k=1:nMasks
       %get mask
       mask = squeeze(masks(k,:,:));
       
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
       
       subplot(1,nMasks+1,1+k);
       imshow(origImg);
       
    end

end

