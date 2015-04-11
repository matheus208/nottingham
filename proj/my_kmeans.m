function [ labels ] = my_kmeans( A , num_clusters)

    [width, height] = size(A);
    max_A = max(A(:));

    %generate cluster centers, each column represents a centroid
    %the rows are the X-Y-Z axis
    cluster_centers(1,:) = randi(width,1,num_clusters);
    cluster_centers(2,:) = randi(height,1,num_clusters);
    cluster_centers(3,:) = randi(max_A,1,num_clusters);
    
    %Initialise the labels matrix
    labels = zeros(size(A));
    old_labels = ones(size(labels));
    
    while any(old_labels~=labels)
        old_labels = labels;
        %For each element of A, decide what centroid is the closest
        for k=1:numel(A)

            %Finds the position i/j
            [i,j] = ind2sub(size(A), k);

            vector = [i j A(k)];

            dist = (sum((cluster_centers - repmat(vector',1,num_clusters)),1).^2).^0.5;
            [~,idx] = min(dist);

            labels(i,j) = idx;
        end
    end
end

