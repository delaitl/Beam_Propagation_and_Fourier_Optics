
% drawing of the output on point carre sphere if Jin = lin pol at 45 deg 
% as a function of Phase
Jin = 1/sqrt(2) * [1 ; 1]

PoincareSphere();
Jout = JJM(Jin,pi/2);
S = JonesToStokes(Jout);
plot3(S(2),S(3),S(4),'ro','markerfacecolor','r','markersize',14);

% for Phase=0:2*pi/100:2*pi
%   %Representation of Jout in the point Carre Sphere
%     Jout = JJM(Jin,Phase);
%     S = JonesToStokes(Jout);
%     plot3(S(2),S(3),S(4),'ro','markerfacecolor','r','markersize',14);
% end

function [Jout] = JJM(Jin,Phase)
        %Calculates the output polarization state in Jones Vector form 
        % as a function of Gamma 
        %Jout = [Joutx ; Jouty] that could be a complex vector
        %Jin : Jin= [Jx ; Jy] and |Jin|=1
        %phase : the phase shift introduced (avance de phase de x) (>0 si FA = X et <0 sinon)

%Jones matrix of the LC with shift
JM = [1 1; 1 1];
JM(1,1) =  1;
JM(1,2) =  0;
JM(2,1) =  0;
JM(2,2) =  exp(-1j*Phase);

%Output Jones vector computation 
Jout = JM*Jin;

end