function PhL = LensPhase(x, lambda, focal)
% Evaluation of the quadratic phase producen by a thin lens in paraxial
% approximation
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

[X,Y] = meshgrid(x,x);
r2 = X.^2 + Y.^2;

PhL = pi/lambda * r2 / focal;
