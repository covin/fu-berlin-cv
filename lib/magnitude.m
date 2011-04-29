function m = magnitude(L, x,y)
  m = sqrt( (L(x+1,y)-L(x-1,y))^2 + (L(x,y+1)-L(x,y-1))^2 );
end
