function y=process_test()
    files = dir('test/');
    
    accuHist = zeros(256,256,256);
    pixSum = 0;
    
    %for each image
    for file = files'
        if(file.isdir) 
            continue; 
        end
        image = imread(strcat('test/',file.name));
        
        %calculate its histogram
        hist = imColourHist(image);
        
        %accumulate it in a general histogram
        accuHist = accuHist + hist;
        pixSum = pixSum + size(image,1) * size(image,2);
    end
    
    %normalise histogram (probability)
    y=accuHist/pixSum;
end


function y=imColourHist(img)
    
    hist = zeros(256,256,256);
    
    for i=1:size(img,1)
        for j=1:size(img,2)
            currVal = hist(img(i,j,1)+1,img(i,j,2)+1,img(i,j,3)+1);
            hist(img(i,j,1)+1,img(i,j,2)+1,img(i,j,3)+1) = currVal + 1 ;
        end
    end
    
    y=hist;
    
end