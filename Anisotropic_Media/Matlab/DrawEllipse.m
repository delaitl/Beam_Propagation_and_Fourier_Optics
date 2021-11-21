function Titulo = DrawEllipse(Figura, Jones, TI, Color)
% Draw the polarization ellipse corresponding to a Jones vector
% In figure(Figura)
% TI is an initial title
% Color is the color to be used
% 
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

figure(Figura)
[An, Phi, Az, Ell]     = JonesToAnglePhase(Jones);
if(Phi >= 0)
    rot = 'Dextro';
else
    rot = 'Levo';
    Color = strcat(Color,'.');
end

tend = 2*pi;
dt = tend/300;
t=0:dt:tend;

Ax = abs(Jones(1));    Ay  = abs(Jones(2));
Ex = Ax * cos(t);      Ey  = Ay * cos(t + Phi);
Axa = Ax;              Aya = Ay;
if(Ax < 0.1)
    Axa = 0.1;
end
if(Ay < 0.1)
    Aya = 0.1;
end

%Draw
plot(Ex, Ey, Color, 'LineWidth', 1);
xlabel('Ex')
ylabel('Ey')
hold on
plot([-Axa Axa], [0 0], 'k')
plot([0 0], [-Aya Aya], 'k')

Titulo = strcat(TI ,  sprintf('\nRotation = %s,  Az=%f,  El=%f',...
    rot,    pi/180*Az,       pi/180*Ell  ) );

title(Titulo );

axis equal tight

