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