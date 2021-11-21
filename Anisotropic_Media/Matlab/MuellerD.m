function M = MuellerD(Type, Rotation, Phase)
% To generate the Mueller matrix of an element rotated an angle
%   Rotation (degrees), if the element is a waveplate which retarder
%   is Phase (degrees).
%   
%   VARIABLES:  Type: 'polarizer', 'waveplate', 'rotation'
%               Rotation: angle to turn the element
%               Phase: retarder of the waveplate
%   
%   USE:        M = Mueller(Type, Rotation, Phase)
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/


switch lower(Type)
    case 'polarizer'
        M = zeros(4,4);
        M(1:2, 1:2) = 0.5;
        M = TurnMatrixMD(M, Rotation);
      
    case 'waveplate'
        M = eye(4);
        M(3,3) = cosd(Phase);
        M(4,4) = cosd(Phase);
        M(3,4) = sind(Phase);
        M(4,3) = -sind(Phase); 
        M = TurnMatrixMD(M, Rotation);
        
    case 'rotation'
        M = eye(4);
        M(2,2) = cosd(2*Rotation);
        M(3,3) = cosd(2*Rotation);
        M(2,3) = sind(2*Rotation);
        M(3,2) = -sind(2*Rotation);   

end
        
 