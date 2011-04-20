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

  I_yuv = zeros(rows,cols,c);
  for i = 1:rows
    for j = 1:cols
      I_yuv(i,j,y) = 0.229 * I_rgb(i,j,red) + 0.587 * I_rgb(i,j,green) + 0,144 * I_rgb(i,j,blue);
      I_yuv(i,j,u) = (I_rgb(i,j,blue) - I_yuv(i,j,y)) * 0.493;
      I_yuv(i,j,v) = (I_rgb(i,j,red) - I_yuv(i,j,y)) * 0.877;
    end
  end
end
