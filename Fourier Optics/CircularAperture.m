function CA = CircularAperture(Dim, Rad)
% Generation of a Circular Aperture of radius Rad
% in a square matrix Dim x Dim
%
% Use
% CA = CircularAperture(Dim, Rad)

% Vector with the x coordinates (y coordinates are the same)
x = 1:Dim;
x = x - double(int32(Dim/2));

% Matrices witht te X, Y coordinates
[X, Y] = meshgrid(x, x);

% Computation of the normalized radius
CA = sqrt(X.^2 + Y.^2)/Rad;

CA( CA <=1 ) = 1; % pixels with radius smaller than 1 are made equal to 1
CA( CA > 1 ) = 0; % The rest are made equal to 0
