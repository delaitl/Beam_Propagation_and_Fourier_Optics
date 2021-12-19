% Drawing the Poincare Sphere

PoincareSphere();

N=80;

% Linear polarization EN ROUGE
El = 0;
del = 360/(N-1);
for Az=0:del:360-del
  S = AzElToStokesD(Az, El);
  plot3(S(2),S(3),S(4),'ro','markerfacecolor','r','markersize',14);
end

% Eliptical polarization with Az=45 and variable ellipticity EN VERT

N=40;
del = 90/(N-1);
for El = -45:del:45
  Az = 45;
  S = AzElToStokesD(Az, El);
  plot3(S(2),S(3),S(4),'go','markerfacecolor','g','markersize',14);
  Az = -45;
  S = AzElToStokesD(Az, El);
  plot3(S(2),S(3),S(4),'go','markerfacecolor','g','markersize',14);
end
