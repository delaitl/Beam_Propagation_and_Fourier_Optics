function [s_prime,M] = dist_magn(R,s,n,n_prime)
    %Function that compute the image distance in cm and the Magnification
    %INPUTS : 
    %   R = the diopter radius [cm]
    %   s = the object distance from the diopterc [cm]
    %   n = the refractive index in the object side
    %   n_prime = the refractive index in the object side

    %   image distance 
%s_prime = n_prime/((n/s)+((n_prime-n)/R));
s_prime = n_prime*s*R/(n*R+(n_prime-n)*s);
    %   Magnification
M = n*s_prime/(n_prime*s);
end