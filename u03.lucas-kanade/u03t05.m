# octave script to calculate sift descriptor for given keypoint

Ic = imread("samples/mrs.easy/101.png");
In = imread("samples/mrs.easy/102.png");


SD4 = calculateSIFTDescriptor (Image, KeyPoint, rot, gridwidth, bsz, bins);
