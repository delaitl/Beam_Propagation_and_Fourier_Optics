function [u2]=FresnelFT(u1,L,lambda,z)
% Fresnel propagation - Fourier Transform approach
% assumes uniform sampling
% u1     - source plane field
% L      - source and observation plane side length
% lambda - wavelength
% z      - propagation distance
% u2     - observation plane field
%
% Use
% [u2]=FresnelFT(u1,L,lambda,z)
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

 [M,N] = size(u1); %get input field array size
 dx    = L/M; %sample interval
 k     = 2*pi/lambda; %wavenumber
 fac   = k/(2*z);

 x     = -L/2:dx:L/2-dx; %coords
[FX,FY] = meshgrid(x,x);

 U2 = u1 .* exp(-1i*fac*(FX.^2+FY.^2));
 u2 = fftshift(fft2(fftshift(U2))); 
 end