function skin_detect(filename)
    limit=0.0001;
    img = imread(filename);
    pHist = process_test();
    mask = zeros(size(img,1),size(img,2),3);
    for i=1:size(img,1)
        for j=1:size(img,2)
            pSkin = isSkin(img(i,j,:), pHist);
            if(pSkin<limit)
                mask(i,j,1)=255;
            end
        end
    end
    subplot(1,2,1),imshow(mask);
    subplot(1,2,2),imshow(img);
end

function z=isSkin(pixel, pHist)
    z=pHist(pixel(1)+1, pixel(2)+1, pixel(3)+1);
end