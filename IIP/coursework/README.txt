Unzip the deliverables.zip file. It contains:
- The training set image (test.jpg)
- 8 test images. 4 are the ones used to build the training set (faceX.jpg files)
  and 4 are additional pictures used to test (outX.jpg)
- 3 Matlab files:
  prob_extractor.m contains the function that processes the training set and
                  generates the 2D probability array
  skin_detector.m contains the function that, given a target image and the
                  probability array, outputs a mask of skin pixels detected by
                  the method
  test.m          Contains a handy tester function. Call it on Matlab passing
                  any number of file names (as strings) as separate arguments.
                  The method then applies the skin_detector function to each
                  image and displays the resulting mask along the original
                  image.
                  This function requires that a 'test.jpg' training set is 
                  located on the same folder.
