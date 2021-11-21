function JM = JonesMatrixR(Type, Rotation, Phase)
% To generate the Jones matrix of an element rotated an angle
%   Rotation (radians), if the element is a waveplate which retarder
%   is Phase (radians).
%   
%   VARIABLES:  Type: 'polarizer', 'waveplate', 'rotation'
%               Rotation: angle to rotate the element
%               Phase: retarder of the waveplate
%   
%   USE:        M = Jones(Type, Rotation, Phase)
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

switch lower(Type)
    case 'polarizer'
        JM = zeros(2,2);
        JM(1,1) = 1;
        if (Rotation ~= 0)
            R = JonesMatrixR('rotation', Rotation, 0);
            JM = R' *JM * R;
        end
    case 'waveplate'
        JM = eye(2);
        JM(2,2) = exp(1i*Phase);
        if (Rotation ~= 0)
            R = JonesMatrixR('rotation', Rotation, 0);
            JM = R' *JM * R;
        end
    case 'rotation'
        JM = eye(2);
        JM(1,1) = cos(Rotation);
        JM(2,2) = cos(Rotation);
        JM(1,2) = sin(Rotation);
        JM(2,1) = -sin(Rotation);
end