function M = detectCorners(I, N)

[r c] = size(I);
W = gaussmatrix(N+1,N/2);
N2 = N/2;
[Dr Dc] = gradient(I);
C = zeros(r,c,2);

for i=N2+1:r-N2
  for j=N2+1:c-N2
    %TODO: think of a way to have two equally sized matrices, or is this okay?
    % by this imean
    S1 = sum(sum(Dr((i-N2):(i+N2),(j-N2):(j+N2)).^2 .* W));
    S2 = S3 = sum(sum(Dr((i-N2):(i+N2),(j-N2):(j+N2)).*Dc((i-N2):(i+N2),(j-N2):(j+N2)) .* W)); 
    S4 = sum(sum(Dc((i-N2):(i+N2),(j-N2):(j+N2)).^2 .* W));
    C(i,j,:) = eig([S1, S2 ; S3, S4]);
  endfor
endfor
%TODO: search for big eigenvalues, one big -> edge, two big -> corner 
% see http://www.cse.yorku.ca/~kosta/CompVis_Notes/harris_detector.pdf
% CAREFUL: this is not be the same corner detector as in the SURF-paper,
% this is from the Harris-Paper, or see
% http://en.wikipedia.org/wiki/Corner_detection#The_Harris_.26_Stephens_.2F_Plessey_.2F_Shi-Tomasi_corner_detection_algorithm
end
