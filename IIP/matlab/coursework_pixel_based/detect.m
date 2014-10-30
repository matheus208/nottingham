function detect(img_name)
    img = imread(img_name);
    subplot(1,2,1) , imshow(img);
    subplot(1,2,2) , imshow(skin_detect(img));