function [Jout] = J_OUT(Jin,beta)
        %Calculates the output polarization state in Jones Vector form 
        % as a function of beta (alpha fixed to pi/2)
        %Jout = [Joutx ; Jouty] that could be a complex vector
        %Jin : Jin= [Jx ; Jy] and |Jin|=1
        %beta : birefringence [rad]
        
%parameters definition
gamma = sqrt((pi/2)^2+beta^2);
X = cos(gamma);
Y = beta/gamma*sin(gamma);
Z = pi/2/gamma*sin(gamma);
        
%Jones matrix of the twisted nematic liquid crystal cell M definition 
A = [0 -1; 1 0];
B = [X-Y*1i Z; -Z X+Y*1i];
M = A*B;

%Output Jones vector computation 
Jout = M*Jin;

end