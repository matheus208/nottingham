function y=process_test_hsv()
    %open training image
    image = imread('test/test3.jpg');
    
    %convert to hsv
    hsv = rgb2hsv(image);
    
    %calculate its histogram
    hist = histHue(hsv); 
    %hue = uint8(round(256*hsv(:,:,1)));
    %hist = imhist(hue, 256);

    %calculate the no. of pixels
    pixSum = size(image,1) * size(image,2);
    %normalise histogram (probability)
    y = hist/pixSum;
    %y = hist / max(hist(:));
    
end
