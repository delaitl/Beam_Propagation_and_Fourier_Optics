function [H]=ChirpFresnelTF(Numx, L,lambda,z)
% Fresnel propagation - Transfer Function approach
% assumes same x and y side lengths and uniform sampling
% Numx   - Size of the square matrix
% L      - source and observation plane side length
% lambda - wavelength
% z      - propagation distance
% u2     - Chirp function
%
% Use
% [H]=ChirpFresnelTF(Numx, L,lambda,z)
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/


 dx    = L/Numx; %sample interval

 fx      = -1/(2*dx):1/L:1/(2*dx)-1/L; %freq coords
 [FX,FY] = meshgrid(fx,fx);

 H  = exp(-1i*pi*lambda*z*(FX.^2+FY.^2)); %trans func