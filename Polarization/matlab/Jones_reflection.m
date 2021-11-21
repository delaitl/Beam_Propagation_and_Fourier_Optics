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

