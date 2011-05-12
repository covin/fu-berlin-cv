
I = imread("samples/mrs.easy/101.png");
if (size(size(I))(2)>2)
  printf("Need grayscale image!")
endif
C = detectCorners(I,20);
