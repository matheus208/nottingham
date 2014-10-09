function y=my_rgb2hsv(image)
    dimensions = size(image);
    width = dimensions(1);
    height = dimensions(2);
    
    for i=1:width
        for j=1:height
            
            %calculating value
            maximum = max(image(i,j,:));
            v(i,j) = maximum;
            
            %calculating saturation
            minimum = min(image(i,j,:));
            s(i,j) = (maximum - minimum)/maximum;
            
            %calculating hue
            %red is maximum
            if(image(i,j,1)==maximum)
                h(i,j) = 0 + 60 * (image(i,j,2)-image(i,j,3));
            end
            
            %green is maximum
            if(image(i,j,2)==maximum)
                h(i,j) = 120 + 60 * (image(i,j,1)-image(i,j,3));
            end
            
            %blue is maximum
            if(image(i,j,3)==maximum)
                h(i,j) = 240 + 60 * (image(i,j,1)-image(i,j,2));
            end
            
            if(h(i,j)>360)
                h(i,j) = mod(j(i,j),360);
            end
                        
            
        end
    end
    
    y = [h,s,v];
    