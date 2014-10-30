function y=my_gammacorrection(image, gamma)
    imageDouble = double(image);
    correctedImage = imageDouble.^gamma;
    y = uint8(correctedImage);