function [An, Phi, Az, Ell] = JonesToAnglePhase(J)

% J Jones vector: 2 complex component
% Given a Jones vector (J) evaluates the Anple(An) Phase(Phi) Azimuth (Az)
% and Ellipticity (Ell) of the polarization ellipse
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

A = abs(J);  % Modulus of the components
PhiJ = angle(J); % Phase of the components

Phi= PhiJ(2)-PhiJ(1);

An = atan2(A(2),A(1));

d = A(1)^2 - A(2)^2;
Az= atan2( 2*A(1)*A(2)*cos(Phi), d ) /2;

if  abs(tan(Phi)) > 1.e4
    Ell = Phi;
else
    Ell = atan( tan(Phi) * sin(2*Az) ) /2;
end

