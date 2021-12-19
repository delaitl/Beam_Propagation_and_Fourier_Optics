function[out] = triangleRect(Lx, Ly, DimX, DimY)

% Generates a Triangle Rectangle
% DimX, DimY: Dimension of the matrix
% Lx, Ly:     Size of the triangle
%
% USE
% [out] = triangleRect(Lx, Ly, DimX, DimY)
x = (1:DimX) - floor(DimX/2);
y = (1:DimY) - floor(DimY/2);

[X,Y] = meshgrid(x,y);

out = X*0 + 1;
out = out .* (Y>=0) .* (Y<=Ly) .* (X>=0) .* (Y<=(Ly - Ly/Lx * X));


