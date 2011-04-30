function SD = calculateSIFTDescriptor (Image, KeyPoint, rot, gridwidth, bsz, bins)
  # octave script to calculate sift descriptor for given keypoint

  [Dx, Dy] = gradient(Image, 0.5);

  step=2*pi/bins;


  SGx = zeros(gridwidth,gridwidth);
  SGy = SGx;
  # SIFT descriptor calculation needs its own coordinate system
  # compute x and y axis in image coordinate system
  #
  # +-----------> x
  # |
  # |  IMAGE
  # |  all angles are relative to top orientation (e.g. Vec(0 -1) has zero angle)
  # /
  # y
  #
  SDC_y = [-tan(rot*pi/180) 1];
  SDC_x = [1 tan(rot*pi/180)];
  SDC_x = SDC_x/norm(SDC_x);
  SDC_y = SDC_y/norm(SDC_y);
  # the origin of SIFT descriptor grid
  O = KeyPoint - (gridwidth/2-0.5)*(SDC_x+SDC_y);

  # fill grid with interpolated gradient information from origianl image gradients
  for y=1:gridwidth
    for x=1:gridwidth
      p = O + x*SDC_x + y*SDC_y;
      SGx(y,x) = gx = interp2(Dx,p(2), p(1));
      SGy(y,x) = gy = interp2(Dy,p(2), p(1));
      SG_magn(y,x) = norm([gx gy]);
    end
  end
  %-----------------------------------------------------------------------
  SG_theta = atan2(SGy, SGx) + pi;
  # unfortunatly SG_theta holds gradient angles in image space
  # we have to handle them relative to grids rotation
  SG_theta -= rot * pi/180;
  SG_theta = mod(SG_theta + 2*pi, 2*pi);
  # weight magnitude in the gaussian way
  g = gaussmatrix(gridwidth, gridwidth/2);
  SG_magn .*= g;

  SD = [];
  # 
  for b_y= 1:gridwidth/bsz
    for b_x = 1:gridwidth/bsz
      x=(b_x-1)*bsz+1;
      y=(b_y-1)*bsz+1;
      B_theta=SG_theta(x:x+bsz-1,y:y+bsz-1);
      B_magn=SG_magn(x:x+bsz-1,y:y+bsz-1);

      G_histo=zeros(1, bins);
      for row=1:bsz-1
        for col=1:bsz-1
          theta = B_theta(row,col);
          prevBin = floor(theta/step);
          nextBin = mod(prevBin+1,bins);
          prevBinDist = abs(prevBin*step-theta)/step;
          nextBinDist = 1-prevBinDist;
          mPrev = (1-prevBinDist)*B_magn(row,col);
          mNext = (1-nextBinDist)*B_magn(row,col);
          G_histo(uint8(prevBin+1)) += mPrev;
          G_histo(uint8(mNext+1))   += mNext;
        end
      end
      SD = [SD G_histo];
      # normalization of the feature vector
      SD = SD/norm(SD);
    end
  end
end
