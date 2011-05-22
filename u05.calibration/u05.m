
% P5100207s: P1(400|160), P2(463|343), P3(166|391), P4(118|190)
Pic1 = [400, 160; 463, 343; 166, 391; 118, 190];
% P5100208s: P1(427|143), P2(567|300), P3(185|376), P4( 88|222)
Pic2 = [427, 143; 567, 300; 185, 376;  88, 222];
% P5100209s: P1(426|166), P2(589|269), P3(177|344), P4( 65|215)
Pic3 = [426, 166; 589, 269; 177, 344;  65, 215];
% P5100210s: P1(435|166), P2(611|231), P3(185|279), P4( 63|196)
Pic4 = [435, 166; 611, 231; 185, 279;  69, 196];
World = [ 10, 10
         220, 10
         220,317
         317, 10];
% sensor dimension of [17.3mm x 13.0mm]
dim = [640, 480];
sen = [17.3, 13];
f   = 38;

function S = pixel2sensor(P_in, Dim, Sensor)
    [pixels, _] = size(P_in);
    P = [];
    for i=1:pixels
        P = [P; P_in(i,:)-Dim/2];
    end
    S = P / diag(Dim) * diag(Sensor);
end


S = pixel2sensor(Pic1, dim, sen)./ f;
[R t] = locateCam(S,World);
t

S = pixel2sensor(Pic2, dim, sen)./f;
[R t] = locateCam(S,World);
t
