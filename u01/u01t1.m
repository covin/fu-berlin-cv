# octave script to apply hadamard transformation on 
# quadratic image with isize 2**p

printf('-- u01/task1 - bayer filtering and demosaicing\n\n');


# load image into matrix
I_in = loadimageprompt();

Bayer = rgb2bayer(I_in);

% TODO implement :P
I_out = bayer2rgb(Bayer);

% image(uint8(I_out));
% image(I_in);
imshow(uint8(Bayer));
% imwrite(uint8(I_con), "u01/h_out.png");


