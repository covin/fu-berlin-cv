# lucas-kanade

Ic = imread("samples/mrs.easy/101.png");
In = imread("samples/mrs.easy/102.png");

F = lucaskanade(double(Ic), double(In), 20, 20, 1);

