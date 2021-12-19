function J = StokesToJones(S)
%Assuming a fully polarization state given by its Stokes vector (S),
%evaluates the cooresponding Jones vector
%
%  Juan Campos
%  Universitat Autonoma de Barcelona
%  http://grupsderecerca.uab.cat/mipoptilab/

J = zeros(2,1);
% Amplitudes of the components
JA( 1) = sqrt ( ( S(1) + S(2) ) /2 );
JA( 2) = sqrt ( (S(1) - S(2) ) /2 );
 
% Phase of the components
JP( 2) = atan2( S(4) , S( 3) );
JP(1) = 0 * JP(2);

% Components of the Jones Vector
J(1) = JA(1) ;
J(2) = JA(2) .*exp(1i*JP(2) ) ;