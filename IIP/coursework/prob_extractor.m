function [ pdf ] = prob_extractor(im)
%PROB_EXTRACTOR Creates a probability matrix based on the input image.
%   Creates a 2d array represetning hue-saturation whose values are the
%   probability of that given hue-saturation.

    hsv = rgb2hsv(im);    

    %calculate hue-saturation histogram
    hist = zeros(361,101);
    for i=1:size(im,1)
        for j=1:size(im,2)
            %extract hue (btwn 0~360 and saturation btwn 0~100)
            hue = hsv(i,j,1);
            hue = round(hue*360);
            
            sat = hsv(i,j,2);
            sat = round(sat*100);
            
            %increases the corresponding element on the histogram
            hist(hue+1,sat+1) = hist(hue+1,sat+1)+1;
        end
    end
    
    %calculates the pdf
    pdf = hist/numel(image);

end

