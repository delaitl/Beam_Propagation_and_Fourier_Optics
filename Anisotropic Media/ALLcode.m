Jin1 = [1 ; 0] % lin pol at 0 deg
Jin2 = [0 ; 1] % lin pol at 90 deg
Jin3 = [1/sqrt(2) ; 1i/sqrt(2)] %circ right pol

%plot of the Jones vectors on the Point Carre sphere
PoincareSphere();
for beta=0:2*pi/100:2*pi
  %Representation of Jout in the point Carre Sphere
    Jout = J_OUT(Jin3,beta);
    S = JonesToStokes(Jout);
    plot3(S(2),S(3),S(4),'ro','markerfacecolor','r','markersize',14);
end

%plot of the intensity for beta between 0 and 2 pi
Intensity = zeros(101);
beta=0:2*pi/100:2*pi;
for  i =1:101
    Intensity(i)= INTENSITY(beta(i));
end

figure
plot(beta,Intensity,'m')

title('Plot 2')
xlabel('beta [rad]')
ylabel('Intensity at the output [W/m^2]')
xlim([0 2*pi])

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


function [intensity] = INTENSITY(beta)
        % Computation of the intensity [W/m^2] if at the input we have linear polarization 
        % at 0º and at the output we place a polarizer with the transmission axis
        % along the y axis         
        %beta : birefringence [rad]

%(1) Jones Vector computation after linear polarizer

Jout1 = J_OUT([1 ; 0],beta);
Jout2 = [0 0; 0 1]*Jout1;

%(2) Computation of the intensity
eta = 377;
intensity = (abs(Jout2(1))^2 + abs(Jout2(2))^2)/(2*eta);


end
