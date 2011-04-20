function Out = rgb2bayer(RGBImage)
  [rows, cols, c] = size(RGBImage);

  if c != 3
    printf('bad parameter for rgb2bayer: Did you pass a RGB image?\n');
    return;
  end
  % create a copy matrix
  C = RGBImage;
  %
  % G | B | G | B ...
  % R | G | R | G ...
  %
  % prepare red channel
  C(1:2:rows,:,1) = 0;
  C(2:2:rows, 2:2:cols, 1) = 0;
  % prepare blue channel
  C(2:2:rows,:,3) = 0;
  C(1:2:rows, 1:2:cols, 3) = 0;
  % prepare green channel
  C(1:2:rows, 2:2:cols, 2) = 0;
  C(2:2:rows, 1:2:cols, 2) = 0;


  Out = C(:,:,1) + C(:,:,2) + C(:,:,3);

end
