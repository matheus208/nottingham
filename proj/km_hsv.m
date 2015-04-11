function [masks] = km_hsv(image, reps, type, clusters)
    
    hsv = rgb2hsv(image);
    
    nrows = size(hsv,1);
    ncols = size(hsv,2);
    
    nColors = clusters;
        
    h = double(hsv(:,:,1)); h=h(:);
    
   % [cluster_idx, ~, sumd] = kmeans(h,...
   %     nColors,...
   %     'distance',type,...
   %     'Replicates',reps,...
   %     'emptyaction','drop',...
   %     'display', 'final',...
   %     'start','cluster');
    cluster_idx = kmeans(h, nColors);
    
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    segmented_images = cell(1,3);
    rgb_label = repmat(pixel_labels,[1 1 3]);

    masks = zeros(nColors, size(image,1), size(image,2));
    for k = 1:nColors
       mask = zeros(size(image,1), size(image,2));
       mask(pixel_labels == k) = 1;
       mask = logical(mask);
       masks(k,:,:) = mask;
    end
    
    masks = logical(masks);
    %subplot(1,nColors+1,1), imshow(image), title('original');
    %color = image;
    %color(rgb_label ~= k) = 255;
    %segmented_images{k} = color;
    %subplot(1,nColors+1,k+1),imshow(segmented_images{k}), title(sprintf('objects in cluster %d',k));