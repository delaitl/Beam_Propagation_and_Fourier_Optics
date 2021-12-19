function [h]=ChirpFresnelIR(Numx, L,lambda,z)
% Fresnel propagation - Impulse Response approach
% assumes same x and y side lengths and uniform sampling
% Numx   - Size of the square matrix
% L      - source and observation plane side length
% lambda - wavelength
% z      - propagation distance
% h     - Chirp function
%
% Use
% [h]=ChirpFresnelIR(Numx, L,lambda,z)
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/



dx   = L/Numx; %sample interval
k    = 2*pi/lambda; %wavenumber

x     = -L/2:dx:L/2-dx; %spatial coords
[X,Y] = meshgrid(x,x);

h  = exp(1i*k/(2*z)*(X.^2+Y.^2)); %impulse Response

