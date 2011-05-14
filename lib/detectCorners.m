# I - the intensity image
# N - neighborhood size, has to be odd
function M = detectCorners(I, N)

[r c] = size(I);
W = gaussmatrix(N,N/2);
N2 = (N-1)/2;
[Dr Dc] = gradient(I);
M = zeros(r,c);

function ret = bigLambda(l)
    ret = l > 10;
end

for i=N2+1:r-N2
  for j=N2+1:c-N2
    %TODO: think of a way to have two equally sized matrices, or is this okay?
    % by this imean
    Ix = Dr((i-N2):(i+N2),(j-N2):(j+N2));
    Iy = Dc((i-N2):(i+N2),(j-N2):(j+N2));

    S1 = sum(sum(Ix.^2 .* W));
    S2 = S3 = sum(sum(Ix.*Iy.*W)); 
    S4 = sum(sum(Iy.^2 .* W));
    l = eig([S1, S2 ; S3, S4]);

    if bigLambda(l(1)) && bigLambda(l(2))
        M(i,j) = 2;
    elseif bigLambda(l(1)) || bigLambda(l(2))
        M(i,j) = 1;
    endif;
  endfor
endfor
%TODO: search for big eigenvalues, one big -> edge, two big -> corner 
% see http://www.cse.yorku.ca/~kosta/CompVis_Notes/harris_detector.pdf
% CAREFUL: this is not be the same corner detector as in the SURF-paper,
% this is from the Harris-Paper, or see
% http://en.wikipedia.org/wiki/Corner_detection#The_Harris_.26_Stephens_.2F_Plessey_.2F_Shi-Tomasi_corner_detection_algorithm
end
