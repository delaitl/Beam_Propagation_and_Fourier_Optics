function [psi_r,chi_r] = Ellipse(Jx,Jy,n,theta1)
    %Compute the psi and chi parameters to caracterize the polarisation
    %after reflection of monochromatic light incident with Jones vector 
    %(Jx , Jy) on a semi-infinite substrate with complex refractive index n
    %The beam comes from a media with refractive index =1 and with an angle
    %theta1(in degrees) w.r.t the normal
    
    
    %Computation of the Jones vector components after reflection
    [Jxr,Jyr] = Jones_reflection(Jx,Jy,n,theta1);
    vJ = [Jxr , Jyr]
    
    %Computation of the parameters psi and chi
    [psi_r,chi_r] = param_pol_Photonics(vJ)
end