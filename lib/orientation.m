function o = orientation(L, x,y)
  #fun-fact: atan2 ist within (-pi,pi), not within (-pi/2,pi/2)
  o = atan2( (L(x,y+1)-L(x,y-1)) , (L(x+1,y)-L(x-1,y)) );
end
