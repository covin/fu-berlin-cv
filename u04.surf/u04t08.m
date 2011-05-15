
% I = loadimageprompt();
I = imread("samples/mrs.easy/101.png");
I = double(I);
[rows, cols] = size(I);

if (size(size(I))(2)>2)
  printf("Need grayscale image!")
endif

C = detectCorners(I,5);

# Visualisation: use HSV space
Out = zeros(rows, cols, 3);
Out(:,:,1) = C(:,:) .* 0.3;
Out(:,:,2) = C(:,:) .* 0.5;
Out(:,:,3) = I(:,:) ./ 255;

Out = hsv2rgb(Out);

imshow(Out);
imwrite(Out, 'u04.surf/u04t08.png');
