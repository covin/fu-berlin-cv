function I_yuv = rgb2yuv(I_rgb)
  red = 1;
  green = 2;
  blue = 3;
  y = 1;
  u = 2;
  v = 3;
  [rows, cols, c] = size(I_rgb);
  if c != 3
    printf('bad parameter for rgb2yuv: Did you pass a RGB image?\n');
    return;
  end
  if (max(max(max(I_rgb))) > 1)
    I_rgb = (1/255)*double(I_rgb);
  end

  I_yuv = zeros(rows,cols,c);
  I_yuv(:,:,y) = 0.229 * I_rgb(:,:,red) + 0.587 * I_rgb(:,:,green) + 0.144 * I_rgb(:,:,blue);
  I_yuv(:,:,u) = (I_rgb(:,:,blue) - I_yuv(:,:,y)) * 0.493;
  I_yuv(:,:,v) = (I_rgb(:,:,red) - I_yuv(:,:,y)) * 0.877;
end
