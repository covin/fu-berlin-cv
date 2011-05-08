# lucas-kanade

Ic = imread("samples/mrs.easy/101.png");
In = imread("samples/mrs.easy/102.png");

# the last parameter changes the windowsize.
F = lucaskanade(double(Ic), double(In), 10);
# the last two parameters change the number of vectors, 
# the smaller the numbers, the more vectors are printed
drawVectorsOnImage(Ic,F,20,20);
print -dpng "u03.lucas-kanade/u03_pic.png";
