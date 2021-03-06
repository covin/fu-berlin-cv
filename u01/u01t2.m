# octave script to apply rgb to yuv conversion to an image

printf('-- u01/task2 - RGB to YUV conversion and frequency of colors in UV space\n\n');

# load image into matrix
I_in = loadimageprompt();

I_out = rgb2yuv(I_in);

% calculate the frequency of UV-pairs
UVfreq = getuvfreq(I_out);

imshow(UVfreq);

imwrite(UVfreq, "u01/UVfreq.png");
