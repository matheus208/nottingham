function y=process_test()

    files = dir('test/');
    
    accuHist = zeros(256,256,256);
    pixSum = 0;
    
    files=[struct('name','test2.jpg', 'isdir',false)];
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
            red = img(i,j,1);
            green = img(i,j,2);
            blue = img(i,j,3);
            
            %ignore really dark colours
            if(red<20 && green<20 && blue<20)
                continue;
            end
            
            currVal = hist(red+1,green+1,blue+1);
            hist(red+1,green+1,blue+1) = currVal + 1 ;
        end
    end
    
    y=hist;
    
end