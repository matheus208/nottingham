function process_test()
    files = dir('coursework_probability_based/test/');
    
    accuHist = zeros(255,255,255);
    pixSum = 0;
    
    %for each image
    for file = files'
        if(file.isdir) 
            continue; 
        end
        image = imread(strcat('coursework_probability_based/test/',file.name));
        
        %calculate its histogram
        hist = imhist(double(image));
        
        %accumulate it in a general histogram
        accuHist = accuHist + hist;
        pixSum = pixSum + size(image,1) * size(image,2);
    end
    
    %normalise histogram (probability)