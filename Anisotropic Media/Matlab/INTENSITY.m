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