function L = SumaSenos(DimX, DimY, PeriodoX, PeriodoY, Ax, Ay)
% Addition of two sinusoidal functions in both directions in a matrix
% of dimensions DimX*DimY 
% Periods of the sinusoidal functions: PeriodoX, PeriodoY 
% and amplitudes Ax, Ay,
%
% Sintaxis
%   L = SumaSenos(DimX, DimY, PeriodoX, PeriodoY, Ax, Ay);

x = 1:DimX;
y = 1:DimY;

[X,Y] = meshgrid(x,y);

L = zeros(DimY, DimX);

if(Ax ~= 0  && PeriodoX ~= 0)
    L = L + Ax * sin( 2*pi*X/PeriodoX);
end

if(Ay ~= 0  && PeriodoY ~= 0)
    L = L + Ay * sin( 2*pi*Y/PeriodoY);
end
