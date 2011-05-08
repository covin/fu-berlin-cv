# apply Lucas-Kanade algorithm on
# Ic - current image
# In - next image
# 
function F = lucaskanade(Ic, In, Xstep, Ystep, N)

  [rows, cols] = size(Ic);
  [Dr, Dc] = gradient(Ic);
  # is that really correct???
  Dt = Ic - In;

  F = zeros(rows,cols,2);
  # gaussian weights
  W = diag(vec(gaussmatrix(2*N+1, N)));

  for r=(1+N):(rows-N)
    for c=(1+N):(cols-N)
      Ir = vec( Dr(r-N:r+N, c-N:c+N));
      Ic = vec( Dc(r-N:r+N, c-N:c+N));
      It = vec(-Dt(r-N:r+N, c-N:c+N));
      S  = [Ir Ic];
      # use pseudo-inverse
      v = pinv(double(S.')*W*double(S))*double(S.')*W*double(It);
      F (r,c,:) = v;
    end
  end
end
