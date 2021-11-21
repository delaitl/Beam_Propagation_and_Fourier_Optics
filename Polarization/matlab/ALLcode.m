%parameters definition
Jx=2i;
Jy=3i;
theta1=73;
n = 3.8 + 0.86i;


%compute psi and chi parameters after reflection
[psi_r,chi_r] = Ellipse(Jx,Jy,n,theta1); 

%compute alpha the fraction of the power that is reflected
R = Energy_reflected(Jx,Jy,n,theta1);




function [Jxr,Jyr] = Jones_reflection(Jx,Jy,n, theta1)
%   Function to compute the jones vector of a reflected beam of 
%   monochromatic light incident with Jones vector (Jx , Jy) on a 
%   semi-infinite substrate with complex refractive index n
%   The beam comes from a media with refractive index =1 and with an angle
%   theta1(in degrees) w.r.t the normal

%   Computation of theta2 (complex in case of a complex n)
theta1 = theta1*pi/180; %angle conversion to radians
theta2 = asin(sin(theta1)/n);

%computation of the 2 reflection coefficients
GammaX = (cos(theta1) - n*cos(theta2))/(cos(theta1)+n*cos(theta2));%coefficient for E orthogonal to the incidence plane
GammaY = (cos(theta2) - n*cos(theta1))/(n*cos(theta1)+cos(theta2));%coefficient for E parallel to the incidence plane

%    Computation of the Jones vector components 
Jxr = GammaX*Jx;
Jyr = -GammaY*Jy;

end


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

function [psi_r,chi_r] = Ellipse(Jx,Jy,n,theta1)
    %Compute the psi and chi parameters to caracterize the polarisation
    %after reflection of monochromatic light incident with Jones vector 
    %(Jx , Jy) on a semi-infinite substrate with complex refractive index n
    %The beam comes from a media with refractive index =1 and with an angle
    %theta1(in degrees) w.r.t the normal
    
    
    %Computation of the Jones vector components after reflection
    [Jxr,Jyr] = Jones_reflection(Jx,Jy,n,theta1);
    vJ = [Jxr , Jyr];
    
    %Computation of the parameters psi and chi
    [psi_r,chi_r] = param_pol_Photonics(vJ)
end

function [R] = Energy_reflected(Jx,Jy,n,theta1)
    %Compute the percentage of reflected energy
    %after reflection of monochromatic light incident with Jones vector 
    %(Jx , Jy) on a semi-infinite substrate with complex refractive index n
    %The beam comes from a media with refractive index =1 and with an angle
    %theta1(in degrees) w.r.t the normal
    
    %Computation of the Jones vector components after reflection
    [Jxr,Jyr] = Jones_reflection(Jx,Jy,n,theta1);

    %Computation of the percentage of intensity that is reflected
    Ii = (abs(Jx))^2 + (abs(Jy))^2;
    Ir = (abs(Jxr))^2 + (abs(Jyr))^2;
    R = Ir/Ii
end

