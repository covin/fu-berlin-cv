function o = orientation(L, x,y)
{
  o = atand( (L(x,y+1)-L(x,y-1)) / (L(x+1,y)-L(x-1,y)) );
}
