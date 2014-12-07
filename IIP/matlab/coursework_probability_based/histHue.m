function y=histHue(img)
    hue = img(:,:,1) * 360;
    sat = img(:,:,2) * 100;
    bins = 25;
    
    hist = zeros(bins+1, bins+1);        

    for i=1:size(img,1)
        for j=1:size(img,2)
            hueBin = 1 + round(hue(i,j)*bins/360);
            satBin = 1 + round(sat(i,j)*bins/100);
            
            hist(hueBin,satBin) = hist(hueBin,satBin) + 1;
        end
    end
    
    y = hist;
    
end