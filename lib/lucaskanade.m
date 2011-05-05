# apply Lucas-Kanade algorithm on
# Ic - current image
# In - next image
# 
function F = lucaskanade(Ic, In, Xstep, Ystep, N)
  [rows, cols] = size(Ic);
  [Dx, Dy] = gradient(Ic);
  # is that really correct???
  Dt = Ic - In;


  for x=Xstep:Xstep:cols
    for y=Ystep:Ystep:rows
      Ix = Dx(y-N:y+N, x-N:x+N);
      Iy = Dy(y-N:y+N, x-N:x+N);
      It = Dt(y-N:y+N, x-N:x+N);
    end
  end
end
