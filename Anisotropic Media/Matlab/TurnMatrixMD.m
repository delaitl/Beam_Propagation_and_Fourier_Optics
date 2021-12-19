function TM = TurnMatrixMD(M, Rotation)
% Turn the Mueller matrix of an element M, an angle Rotation
%
%   VARIABLES:  M: Mueller Matrix of the element that we want to rotate
%               Rotation: Rotation angle in degrees
%   
%   USE:        TM = TurnMatrixMD(M, Rotation)
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

TM = MuellerD('rotation', -Rotation, 0.0) * M * MuellerD('rotation', Rotation, 0.0);