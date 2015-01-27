
function test_km_hsv()
    % input rgb colour image 
    imrgb = imread('727_S2_T1-green.tif');

    % convert rgb to hsv
    imhsv = rgb2hsv(imrgb);

    % make a copy of the h-channel 
    h = double(imhsv(:,:,1));

    % store the size of the image and convert the (n x m) matrix into a (n*m x 1) vector 
    nrows = size(h,1);
    ncols = size(h,2);
    h = reshape(h,nrows*ncols,1);

    % number of clusters - change to 4 for 4-clusters, etc.
    nColors = 3;

    % perform kmeans - increase replicates to 3, in order to overcome local minima
    [cluster_idx, cluster_center] = kmeans(h, nColors, 'distance', 'sqEuclidean', 'Replicates', 1);

    % cluster indexes - convert the vecotr back to a (n x m) matrix
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    imshow(pixel_labels,[]);

    % replicate the cluster index 3-times to use as a mask for the rgb image in the loop below
    segmented_images = cell(1,3);
    rgb_label = repmat(pixel_labels,[1 1 3]);

    % mask the original rgb image with the cluster masks
    for k = 1:nColors
        color = imrgb;
        color(rgb_label ~= k) = 0;
        segmented_images{k} = color;
    end

    % show claster 1 - change index to 2, 3 etc. for other clusters
    subplot(1,2,1);
    imshow(segmented_images{1});
    % show claster 2 - change index to 2, 3 etc. for other clusters
    subplot(1,2,2);
    imshow(segmented_images{2});
end