function UVfreq = getuvfreq(I_yuv)
  u = 2;
  v = 3;
  u_min = -.40229;
  u_max = .42201;
  v_min = -.64109;
  v_max = .67617;
  [rows, cols, c] = size(I_yuv);

  UVfreq = zeros(256,256);
  
  % this should u and v discrete values between 1 and 256
  I_yuv(:,:,u) = ceil((I_yuv(:,:,u) - u_min) * (255/(u_max-u_min)));
  I_yuv(:,:,v) = ceil((I_yuv(:,:,v) - v_min) * (255/(v_max-v_min)));
  for i = 1:rows
    for j = 1:cols
      UVfreq(I_yuv(i,j,u),I_yuv(i,j,v))+=1;
    endfor
  endfor
end
