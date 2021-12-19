function L = TiltedSin(DimX, DimY, Periodo, Tilt)
% Generation of a sinusoidel function
% matrix de dimensions DimX*DimY 
% Period - Periodo
% tilt angle in degrees - Tilt
%
% Sintaxis
%   L = TiltedSin(DimX, DimY, Periodo, Tilt);

x = 1:DimX;
y = 1:DimY;

[X,Y] = meshgrid(x,y);

fX = sin(Tilt*pi/180)/Periodo;
fY = cos(Tilt*pi/180)/Periodo;

L = sin(2*pi*(X*fX + Y*fY));


