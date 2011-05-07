# lucas-kanade

Ic = imread("samples/mrs.easy/101.png");
In = imread("samples/mrs.easy/102.png");

F = lucaskanade(double(Ic), double(In), 5, 5, 10);
drawVectorsOnImage(Ic,F,20,20);
print -dpng "u03.lucas-kanade/u03_pic.png";
