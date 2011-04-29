function desc = calculateSIFTDescriptor (L,x,y)
  # descriptor as a multidimensionla array with left upper corner (1,1)
  desc = zeros(4,4,8);

#this is not right
  for i=-8:8
    for j=-8:8
      if (i == 0 || j == 0)
      if (i>0)
        if (j>0)
          desc_select = 4;
        else
          desc_select = 2;
        endif
      else
        if (j>0)
          desc_select = 3;
        else
          desc_select = 1;
        endif
      endif
      bin = uint8(8*(orientation(L,x+i,y+j) + pi)/(pi*2));  
      weight = exp( -( i*i + j*j ) / (2 * (16)^2));
      desc(desc_select,bin) += weight*magnitude(L,x+i,y+j);
    endfor
  endfor  
end
