function S = AzElToStokesD(Az, El)
% Input data in degrees
% Given the Azimuth and Ellpiticiy calculates the Stokes parameters
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

Az = 2*Az;
cAz = cosd(Az);
sAz = sind(Az);

El = 2*El;
cEl = cosd(El);
sEl = sind(El);

S=zeros(4,1);
S(1) = 1;
S(2) = cAz * cEl;
S(3) = sAz * cEl;
S(4) = sEl;