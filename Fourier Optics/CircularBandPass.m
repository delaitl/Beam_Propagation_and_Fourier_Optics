function GBPF = CircularBandPass(Dim, x, y, r)
% Generates a Circular Band Pass filter in an image of size (Dim x Dim)
% The circle is centered at (x,y) and (-x,-y) with respect to the center
% of the matrix, and has a radius r


L = CircularAperture(Dim, r);

GBPF = circshift(L, [-y x]) + circshift(L, [y -x]);

GBPF( GBPF>1) = 1; % in case of superposition