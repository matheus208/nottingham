function test(varargin)
%TEST Test the skin detector.
%   Call this function with any number of arguments, each representing the
%   filename of the image(s) to run through the skin detector.
%   An output of each image and the resulting mask will be shown.
%   It is important that the training set image is in the same folder and
%   is called "test.jpg"
%   Example of use: 
%   test('face1.jpg', 'out1.jpg', face2.jpg');
%   This will run the skin detector on the three images and show them with
%   the respective masks.   

    training = 'test.jpg';
    imT = imread(training);
    pdf = prob_extractor(imT);
    
    for i=1:nargin
        target = varargin(i);
        imA = imread(char(target));

        mask = skin_detector(imA,pdf);

        subplot(2,nargin,i),imshow(imA);
        subplot(2,nargin,nargin+i),imshow(mask), title(sprintf('Face %d',i));
    end
end

