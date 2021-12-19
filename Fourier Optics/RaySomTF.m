function [u2]=RaySomTF(u1,L,lambda,z)
 % Raygley_Sommerfeld propagation - Transfer Function approach
 % assumes same x and y side lengths and uniform sampling
 % u1     - source plane field
 % L      - source and observation plane side length
 % lambda - wavelength
 % z      - propagation distance
 % u2     - observation plane field
 %
 % Use
 % [u2]=RaySomTF(u1,L,lambda,z)

 [M,N] = size(u1); %get input field array size
 dx    = L/M; %sample interval
 k     = 2*pi/lambda; %wavenumber

 fx      = -1/(2*dx):1/L:1/(2*dx)-1/L; %freq coords
 [FX,FY] = meshgrid(fx,fx);
 FX = FX * lambda;
 FY = FY * lambda;

 H  = exp(1i*k*z*sqrt(1-FX.^2-FY.^2)); %trans func
 H  = fftshift(H); %shift trans func
 U1 = fft2(fftshift(u1)); %shift, fft src field
 U2 = H.*U1; %multiply
 u2 = ifftshift(ifft2(U2)); %inv fft, center obs field
 end