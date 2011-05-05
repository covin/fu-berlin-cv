# apply Lucas-Kanade algorithm on
# Ic - current image
# In - next image
# 
function F = lucaskanade(Ic, In, Xstep, Ystep, N)
  [rows, cols] = size(Ic);
  [Dx, Dy] = gradient(Ic);
  # is that really correct???
  Dt = Ic - In;

  F = zeros(0,0,2);
  # gaussian weights
  W = diag(vec(gaussmatrix(2*N+1, N)));

  row = 1;
  for x=Xstep:Xstep:cols
    vecs = [];
    for y=Ystep:Ystep:rows
      Ix = vec( Dx(y-N:y+N, x-N:x+N));
      Iy = vec( Dy(y-N:y+N, x-N:x+N));
      It = vec(-Dt(y-N:y+N, x-N:x+N));
      S  = [Ix Iy];
      # octave comes with: warning: inverse: matrix singular to machine 
      # precision, rcond = 0
      # 
      v = inv(S.'*W*S)*S.'*W*It;
      vecs = [vecs v];
    end
  end
end
