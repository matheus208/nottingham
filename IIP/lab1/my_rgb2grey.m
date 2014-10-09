function y=my_rgb2grey(image, weigh)
    greyScale = double(image);
    if weigh
        x=(0.30*greyScale(:,:,1)+0.59*greyScale(:,:,2)+0.11*greyScale(:,:,3))/3;
    else
        x=(greyScale(:,:,1)+greyScale(:,:,2)+greyScale(:,:,3))/3;
    end
    y = uint8(x);
    