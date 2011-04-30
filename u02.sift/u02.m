# octave script to calculate sift descriptor for given keypoint

Image = imread("samples/kermit001.bmp");
Image = rgb2yuv(Image);
Image = Image( :, :, 1);

KeyPoint = [320, 240];
rot = 0; 
gridwidth = 16;
# blocksize
bsz=4;
# number of histogram bins
bins=8;

SD3 = calculateSIFTDescriptor (Image, KeyPoint, rot, gridwidth, bsz, bins);

KeyPoint = [320.25, 240.125];
rot = 13; 
gridwidth = 16;
# blocksize
bsz=4;
# number of histogram bins
bins=8;

SD4 = calculateSIFTDescriptor (Image, KeyPoint, rot, gridwidth, bsz, bins);
