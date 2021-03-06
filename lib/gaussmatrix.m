function M = gaussmatrix(N,sigma)
    m = (N+1)/2;
    M = zeros(N);
    for x=1:N
        for y=1:N
            M(x,y) = gauss2d(x-m,y-m,sigma);
        end
    end
end
