function [alpha] = Energy_reflected(Jx,Jy,n,theta1)
    %Compute the percentage of reflected energy
    %after reflection of monochromatic light incident with Jones vector 
    %(Jx , Jy) on a semi-infinite substrate with complex refractive index n
    %The beam comes from a media with refractive index =1 and with an angle
    %theta1(in degrees) w.r.t the normal
    
    %Computation of the Jones vector components after reflection
    [Jxr,Jyr] = Jones_reflection(Jx,Jy,n,theta1)

    %Computation of the percentage of intensity that is reflected
    Ii = (abs(Jx))^2 + (abs(Jy))^2;
    Ir = (abs(Jxr))^2 + (abs(Jyr))^2;
    alpha = Ir/Ii
end

