% returns calibration with rotation R and translation t
function [R t] = locateCam(I, W)
  [points, dim] = size(I);
  if points != 4
    printf('are you kidding me? I exactly need four points\n');
  endif
  if size(I) != size(W)
    printf('invalid coordinate mapping\n');
  endif
  x = 1;
  y = 2;

  F = [];
  for p=1:points
     F = [F; W(p,x) W(p,y) 1      0      0 0 -I(p,x)*W(p,x) -I(p,x)*W(p,y) -I(p,x)];
     F = [F;      0      0 0 W(p,x) W(p,y) 1 -I(p,y)*W(p,x) -I(p,y)*W(p,y) -I(p,y)];
  end
  h = inv(F(:,1:8))*-F(:,9);
  H = [h(1) h(2) h(3)
       h(4) h(5) h(6)
       h(7) h(8)   1];
  H /= norm(H(:,1));
  r1 = H(:,1);
  r2 = H(:,2);
  r3 = cross(r1, r2);
  R  = [r1 r2 r3];
  t  = -R^-1*H(:,3);
end

