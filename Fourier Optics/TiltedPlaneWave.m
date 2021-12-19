function P = TiltedPlaneWave(Ndim, lambda, xtilt, ytilt, Sampling)

% lambda in mm    :  Wave Length
% Sampling in mm  :  Sampling distance in the output plane
% xtilt, ytilt (in degrees):  center of the wave

x = 0:Ndim-1;
x = x - Ndim/2;
x = x * Sampling;

[X, Y] = meshgrid(x, x);

sx = sin(xtilt*pi/180);
sy = sin(ytilt*pi/180);

k = 2*pi/lambda;

P = exp(-1i*k*(X*sx + Y*sy));