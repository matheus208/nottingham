function y=my_histeq(image)
    %initial data
    dimension = size(image);
    width = dimension(1);
    height = dimension(2);
    numOfPix = width*height;
    
    %get histogram
    hist=my_hist(image);
    %probability
    probHist = hist/numOfPix;
    
    %calculate cumulative distribution function
    cdf = zeros(1,size(probHist,2));    
    cdf(1) = probHist(1);
    for i=2:size(probHist,2)
        cdf(i) = cdf(i-1) + probHist(i);
    end
    
    %normalise it to [0,255]
    eqHist = 255*(cdf-min(cdf))/(max(cdf)-min(cdf));
    y=zeros(size(image,1),size(image,2));
    
    %creates the final image with the lookup function
    for i=1:width
        for j=1:height
            y(i,j)=eqHist(image(i,j));
        end
    end
    
    %rounds off values to we have integers
    y = uint8(y)