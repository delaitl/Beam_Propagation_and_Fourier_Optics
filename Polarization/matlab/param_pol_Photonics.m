% calc params de polarització del vector de Jones vJ 
% formules pags 29 i 33 de Azzam, noms dels angles segons Photonics, ch. 6
% modified version from the course 
function [psi,chi]=param_pol_Photonics(vJ) 
    if (vJ(1)==0. && vJ(2)==0.), psi=0; chi=0;nr=0; fi=NaN;
    elseif (vJ(1)==0.),psi=-pi/2;chi=0;r=abs(vJ(2));fi=angle(vJ(2));
    else
        aux=vJ(2)/vJ(1);
        tan2psi=2*real(aux)/(1-(abs(aux))^2);
        psi1=atan(tan2psi)/2; 
        psi2=psi1+pi/2;
        psi3=psi1-pi/2;
        if (real(aux)>0 && psi1>0 && psi1>=-pi/2 && psi1<pi/2)psi=psi1; end 
        if (real(aux)>0 && psi2>0 && psi2>=-pi/2 && psi2<pi/2) psi=psi2; end 
        if (real(aux)>0 && psi3>0 && psi3>=-pi/2 && psi3<pi/2) psi=psi3; end 
        if (real(aux)<0 && psi1<0 && psi1>=-pi/2 && psi1<pi/2) psi=psi1; end 
        if (real(aux)<0 && psi2<0 && psi2>=-pi/2 && psi2<pi/2) psi=psi2; end 
        if (real(aux)<0 && psi3<0 && psi3>=-pi/2 && psi3<pi/2) psi=psi3; end 
        if (real(aux)==0 && abs(aux)>1), psi=-pi/2; end 
        if (real(aux)==0 && abs(aux)<1), psi=0; end 
        if (real(aux)==0 && abs(aux)==1), psi=0; end 
        sin2chi=2*imag(aux)/(1+(abs(aux))^2); 
        chi=asin(sin2chi)/2; 
    end
end