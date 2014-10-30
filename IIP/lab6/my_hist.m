function y=my_hist(image)
    dimension = size(image);
    width = dimension(1);
    height = dimension(2);
    histogram = zeros(1,255);
    
    for i=1:width
        for j=1:height
            histogram(image(i,j)+1) = histogram(image(i,j)+1) + 1;
        end        
    end
    
    y = double(histogram);