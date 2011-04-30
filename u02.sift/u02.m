# octave script to calculate sift descriptor for given keypoint

Image = imread("samples/kermit001.bmp");
Image = rgb2yuv(Image);
Image = Image( :, :, 1);

[Dx, Dy] = gradient(Image, 0.5);

KeyPoint = [320.25, 240.125];
rot = 13; 
gridwidth = 16;
# blocksize
bsz=4;
# number of histogram bins
bins=8;
step=2*pi/bins;


SGx = zeros(gridwidth,gridwidth);
SGy = SGx;
# SIFT descriptor calculation needs its own coordinate system
# compute x and y achsis in image coordinate system
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
O = KeyPoint - gridwidth/2 - 0.5

# fill grid with interpolated gradient information from origianl image gradients
for y=1:gridwidth
  for x=1:gridwidth
    p = O + x*SDC_x + y*SDC_y;
    SGx(y,x) = gx = interp2(Dx,p(2), p(1));
    SGy(y,x) = gy = interp2(Dy,p(2), p(1));
    SG_magn(y,x) = m = norm([gx gy]);
    teta = acos(gy/(m+0.00001));
    if gx<0
      if gy<0 
        teta =2*pi-teta;
      else 
        teta += pi; 
      endif 
    endif
    SG_teta(y,x) = teta;
  end
end
# unfortunatly SG_teta holds gradient angles in image space
# we have to handle them relative to grids rotation
SG_teta -= rot * pi/180;
# weight magnitude in the gaussian way
g = gaussmatrix(gridwidth, gridwidth/2);
SG_magn .*= g;

SD = [];
# 
for b_y= 1:gridwidth/bsz
  for b_x = 1:gridwidth/bsz
    x=(b_x-1)*bsz+1;
    y=(b_y-1)*bsz+1;
    B_teta=SG_teta(x:x+bsz-1,y:y+bsz-1);
    B_magn=SG_magn(x:x+bsz-1,y:y+bsz-1);

    G_histo=zeros(1, bins);
    for row=1:bsz-1
      for col=1:bsz-1
        teta = B_teta(row,col);
        prevBin = floor(teta/step);
        nextBin = mod(prevBin+1,bins);
        prevBinDist = abs(prevBin*step-teta)/step;
        nextBinDist = 1-prevBinDist;
        mPrev = (1-prevBinDist)*B_magn(row,col);
        mNext = (1-nextBinDist)*B_magn(row,col);
        G_histo(uint8(prevBin+1)) += mPrev;
        G_histo(uint8(mNext+1))   += mNext;
      end
    end
    SD = [SD G_histo];
  end
end
SD

