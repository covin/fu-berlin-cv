# octave script to calculate sift descriptor for given keypoint

Image = loadimageprompt();
Image = rgb2yuv(Image);
Image = Image( :, :, 1);
siftdesc(Image,uint16(480/2),uint16(640/2));
