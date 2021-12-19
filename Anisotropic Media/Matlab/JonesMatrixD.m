function JM = JonesMatrixD(Type, Rotation, Phase)
% To generate the Jones matrix of an element rotated an angle
%   Rotation (degrees), if the element is a waveplate which retarder
%   is Phase (degrees).
%   
%   VARIABLES:  Type: 'polarizer', 'waveplate', 'rotation'
%               Rotation: angle to turn the element
%               Phase: retarder of the waveplate
%   
%   USE:        M = Jones(Type, Rotation, Phase)
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

% Pass to radians
%Rotation = deg2rad(Rotation);
%Phase    = deg2rad(Phase);
Rotation = pi/180*Rotation;
Phase    = pi/180*Phase;

% Use the function written in radians
JM = JonesMatrixR(Type, Rotation, Phase);