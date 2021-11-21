function S = Az_El_To_Stokes(Az, El)
% Azimuth/Ellipticity  to Stokes
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

Az = 2*Az;
cAz = cos(Az);
sAz = sin(Az);

El = 2*El;
cEl = cos(El);
sEl = sin(El);

S=zeros(4,1);
S(1) = 1;
S(2) = cAz * cEl;
S(3) = sAz * cEl;
S(4) = sEl;