function S = JonesToStokes(J)

% J Jones vector: 2 complex component
% Given a Jones vector (J) evaluates the equivalent Stokes vector (S)
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

A = abs(J);  % Modulus of the components
PhiJ = angle(J); % Phase of the components

Phi= PhiJ(2)-PhiJ(1); % Phase difference

S = zeros(4,1);
S(1) = A(1).^2 + A(2).^2;
S(2) = A(1).^2 - A(2).^2;
S(3) = 2*A(1).*A(2).*cos(Phi);
S(4) = 2*A(1).*A(2).*sin(Phi);