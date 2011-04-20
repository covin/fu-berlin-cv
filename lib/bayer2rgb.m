function I_rgb = bayer2rgb(I_bayer)
  global B r c
  [rows, cols] = size(I_bayer);
  red = 1;
  green = 2;
  blue = 3;

  I_rgb = zeros(rows, cols, 3);
  B = I_bayer;
% apply a kernel in current global position row r and column c of bayer image B
  function v = apply(K)
    global B r c
    % determine kernel size
    [rowsK, colsK] = size(K);
    % create 'view matrix' according to kernel size
    rFrom = r-floor(rowsK/2);
    cFrom = c-floor(colsK/2);
    Sub = B(rFrom:rFrom+rowsK-1,cFrom:cFrom+colsK-1);

    v = sum(sum(Sub.*K));
  end

%-------------------------------------------------------------------------------
% Kernel definitions:
  G_at_R = [ 0  0 -1  0  0
             0  0  2  0  0
            -1  2  4  2 -1
             0  0  2  0  0
             0  0 -1  0  0];
  G_at_R /= 8;
  G_at_B = G_at_R;
  
  R_at_G_in_Rrow_Bcol  = [ 0  0 0.5 0  0
                           0 -1  0 -1  0
                          -1  4  5  4 -1
                           0 -1  0 -1  0
                           0  0 0.5 0  0]* 1/8;
  R_at_G_in_Brow_Rcol = R_at_G_in_Rrow_Bcol';
  B_at_G_in_Brow_Rcol = R_at_G_in_Rrow_Bcol;
  B_at_G_in_Rrow_Bcol = R_at_G_in_Brow_Rcol;
  R_at_B = [ 0   0 -3/2  0   0
             0   2   0   2   0
            -3/2 0   6   0 -3/2
             0   2   0   2   0
             0   0 -3/2  0   0]*1/8;
  B_at_R = R_at_B;
%-------------------------------------------------------------------------------
  for r = 3:(rows-2)
    for c = 3:(cols-2)
      % first: copy 
      
      % red row
      if mod(r,2) == 0
        if mod(c,2) == 0
          % red row, blue column
          I_rgb(r,c,green) = I_bayer(r,c);
          I_rgb(r,c,red) = apply(R_at_G_in_Rrow_Bcol);
          I_rgb(r,c,blue) = apply(B_at_G_in_Rrow_Bcol);
        else
          % red row, red column
          I_rgb(r,c,red) = I_bayer(r,c);
          I_rgb(r,c,green) = apply(G_at_R);
          I_rgb(r,c,blue) = apply(B_at_R);
        end
      % blue row
      else 
        if mod(c,2) == 0
          % blue row, blue column
          I_rgb(r,c,blue) = I_bayer(r,c);
          I_rgb(r,c,green) = apply(G_at_B);
          I_rgb(r,c,red) = apply(R_at_B);
        else
          % blue row, red column
          I_rgb(r,c,green) = I_bayer(r,c);
          I_rgb(r,c,red) = apply(R_at_G_in_Brow_Rcol);
          I_rgb(r,c,blue) = apply(B_at_G_in_Brow_Rcol);
        end
      end
    end
  end
end

