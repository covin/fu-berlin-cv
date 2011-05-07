# display Vectors on a picture
# Im - image
# V - vectors
# Xstep, Ystep - distance between vectors
# 
function F = drawVectorsOnImage(Im, V, Xstep, Ystep)
  [rows, cols] = size(Im);
  r = Ystep:Ystep:rows;  
  c=Xstep:Xstep:cols;
  imshow(Im);
  hold on;
  quiver(c,r,V(r,c,1),V(r,c,2),s=0);
  hold off;
  
 # for x=Xstep:Xstep:cols
  #  for y=Ystep:Ystep:rows
      
   # end
#  end
end
