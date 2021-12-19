function [u2]=AngularSpectrum(u1,L,lambda,z)
% Angular spectrum propagation
% assumes same x and y side lengths and uniform sampling
% u1     - source plane field
% L      - source and observation plane side length
% lambda - wavelength
% z      - propagation distance
% u2     - observation plane field
%
% Use
% [u2]=AngularSpectrum(u1,L,lambda,z)
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

 [M,N] = size(u1); %get input field array size
 dx    = L/M; %sample interval
 L2 = 1/lambda;
 L2 = L2^2;

 fx      = -1/(2*dx):1/L:1/(2*dx)-1/L; %freq coords
 [FX,FY] = meshgrid(fx,fx);
 
 Q = L2 - FX.^2 - FY.^2;
 Q(Q<0) = 0;
 
 H  = exp(1i*2*pi*z*sqrt(Q)); %trans func
 H  = fftshift(H); %shift trans func
 U1 = fft2(fftshift(u1)); %shift, fft src field
 U2 = H.*U1; %multiply
 u2 = ifftshift(ifft2(U2)); %inv fft, center obs field
 end