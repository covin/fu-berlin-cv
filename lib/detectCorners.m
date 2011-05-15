% I - the intensity image
% N - neighborhood size, has to be odd
% 
% returns a matrix of image dimension classifying each pixel M(y,x) as
% 0 - nothing
% 1 - edge
% 2 - corner
function M = detectCorners(I, N)
    if mod(N,2) == 0
        printf('unsupported neighborhood size in corner detector');
        return;
    endif
    
    [r c] = size(I);
    W = gaussmatrix(N,N/2);
    N2 = (N-1)/2;
    [Dr Dc] = gradient(I);
    M = zeros(r,c);
    
    for i=N2+1:r-N2
      for j=N2+1:c-N2
        % create windows around current pixel (j,i)
        Ix = Dr((i-N2):(i+N2),(j-N2):(j+N2));
        Iy = Dc((i-N2):(i+N2),(j-N2):(j+N2));
    
        % see http://www.cse.yorku.ca/~kosta/CompVis_Notes/harris_detector.pdf
        % CAREFUL: this is not be the same corner detector as in the SURF-paper,
        % this is from the Harris-Paper
        S1 = sum(sum(Ix.^2 .* W));
        S2 = S3 = sum(sum(Ix.*Iy.*W)); 
        S4 = sum(sum(Iy.^2 .* W));
        C = [S1, S2 ; S3, S4];
        % is there any scaling possibility for better 'big lambda' decision?
        l = eig(C);
        % search for big eigenvalues, one big -> edge, two big -> corner 
        if bigLambda(l(1)) && bigLambda(l(2))
            M(i,j) = 2;
        elseif bigLambda(l(1)) || bigLambda(l(2))
            M(i,j) = 1;
        endif;
      endfor
    endfor
end

function ret = bigLambda(l)
    ret = l > 25;
end
