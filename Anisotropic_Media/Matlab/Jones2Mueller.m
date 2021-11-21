function M = Jones2Mueller(J)
% Pass a Jones matrix (J) to his Mueller representation (M)
%
%   VARIABLES:  J: Jones matrix
%
%   USE:        M = Jones2Mueller(J)
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

M = zeros(4,4);
i = sqrt(-1);

M(1,1) =real(    J(1,1)*conj(J(1,1)) + J(1,2)*conj(J(1,2)) + J(2,1)*conj(J(2,1)) + J(2,2)*conj(J(2,2)) );
M(1,2) =real(    J(1,1)*conj(J(1,1)) + J(2,1)*conj(J(2,1)) - J(1,2)*conj(J(1,2)) - J(2,2)*conj(J(2,2)) );
M(1,3) =real(    J(1,2)*conj(J(1,1)) + J(2,2)*conj(J(2,1)) + J(1,1)*conj(J(1,2)) + J(2,1)*conj(J(2,2)) );
M(1,4) =real( i*(J(1,2)*conj(J(1,1)) + J(2,2)*conj(J(2,1)) - J(1,1)*conj(J(1,2)) - J(2,1)*conj(J(2,2))) );

M(2,1) =real(    J(1,1)*conj(J(1,1)) + J(1,2)*conj(J(1,2)) - J(2,1)*conj(J(2,1)) - J(2,2)*conj(J(2,2)) );
M(2,2) =real(    J(1,1)*conj(J(1,1)) - J(2,1)*conj(J(2,1)) - J(1,2)*conj(J(1,2)) + J(2,2)*conj(J(2,2)) );
M(2,3) =real(    J(1,1)*conj(J(1,2)) + J(1,2)*conj(J(1,1)) - J(2,1)*conj(J(2,2)) - J(2,2)*conj(J(2,1)) );
M(2,4) =real( i*(J(1,2)*conj(J(1,1)) + J(2,1)*conj(J(2,2)) - J(2,2)*conj(J(2,1)) - J(1,1)*conj(J(1,2))) );

M(3,1) =real(    J(1,1)*conj(J(2,1)) + J(2,1)*conj(J(1,1)) + J(1,2)*conj(J(2,2)) + J(2,2)*conj(J(1,2)) );
M(3,2) =real(    J(1,1)*conj(J(2,1)) + J(2,1)*conj(J(1,1)) - J(1,2)*conj(J(2,2)) - J(2,2)*conj(J(1,2)) );
M(3,3) =real(    J(1,1)*conj(J(2,2)) + J(1,2)*conj(J(2,1)) + J(2,1)*conj(J(1,2)) + J(2,2)*conj(J(1,1)) );
M(3,4) =real(i*(-J(1,1)*conj(J(2,2)) + J(1,2)*conj(J(2,1)) - J(2,1)*conj(J(1,2)) + J(2,2)*conj(J(1,1))) );

M(4,1) =real( i*(J(1,1)*conj(J(2,1)) + J(1,2)*conj(J(2,2)) - J(2,1)*conj(J(1,1)) - J(2,2)*conj(J(1,2))) );
M(4,2) =real( i*(J(1,1)*conj(J(2,1)) - J(1,2)*conj(J(2,2)) - J(2,1)*conj(J(1,1)) + J(2,2)*conj(J(1,2))) );
M(4,3) =real( i*(J(1,1)*conj(J(2,2)) + J(1,2)*conj(J(2,1)) - J(2,1)*conj(J(1,2)) - J(2,2)*conj(J(1,1))) );
M(4,4) =real(    J(1,1)*conj(J(2,2)) - J(1,2)*conj(J(2,1)) - J(2,1)*conj(J(1,2)) + J(2,2)*conj(J(1,1)) );

M = M/2;
