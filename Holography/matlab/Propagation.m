function [u2]=Propagation(u1,L,lambda,z)
% Propagation of a wave by using either the Angular spectrum of plane waves
% or the Fresnel Impulse Response, depending on the propagation distance z
% assumes same x and y side lengths and uniform sampling
% u1     - source plane field
% L      - source and observation plane side length
% lambda - wavelength
% z      - propagation distance
% u2     - observation plane field
%
% Use
% [u2]=FresnelIR(u1,L,lambda,z)
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/


[M,N] = size(u1);
dx1 = L/M;
zmax = L * dx1 / lambda;

if z > zmax
    [u2]=FresnelIR(u1,L,lambda,z);
else
    [u2]=AngularSpectrum(u1,L,lambda,z);
end