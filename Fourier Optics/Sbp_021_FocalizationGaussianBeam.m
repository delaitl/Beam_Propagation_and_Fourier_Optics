% Focalization of a Gaussian Beam
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

clc
format compact

% Size and shampling at the source plane
L1 = 20; %side length (mm) of the image
M  = 1024; %number of samples
lambda = 0.0005; %wavelength (mm)
k = 2*pi/lambda; %wavenumber

% Gaussian Definition at the beam waist
w0 = 0.2; %1.1; %Gaussian with (mm)
z0 = k*w0^2/2;  % Rayleigh range
printf('z0=%f\n', z0);

% Delta X (mm) in the source plane
dx1 = L1/M;
x1=-L1/2:dx1:L1/2-dx1; %src coords
% Critial distance z (mm)
zcrit = L1 * dx1 / lambda;
%disp(zcrit);

[X,Y] = meshgrid(x1, x1);
R2 = X.^2 + Y.^2;


% Gaussian function at the source plane
g = Gaussian_mm(w0, R2);
gi = g.^2;

% Source plane
figure(1)
subplot(2,3,1)
imagesc(x1,x1,gi);
axis square; axis xy;
colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
title('z= 0 mm');

subplot(2,3,2)
plot(x1, gi( int32(M/2),:) );
xlabel('x (mm)'); ylabel('Intensity')

% Lens definition
f = 1000; % Focal length of the lens in mm
d0 = 2000; % Location of the beam waist in mm
Lens = exp(-1i*LensPhase(x1, lambda, f) );


subplot(2,3,3)
imagesc(x1,x1,angle(Lens) );
axis square; axis xy;
colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
title('Lens Phase');

%% Propagation and pass through the lens
[gp]=Propagation(g,L1,lambda,d0);  % Propagation
gp = gp.*Lens; % Passing the lens

%% Propagation to the new waist
M2 = f*f / ((d0-f)^2 + z0^2);
d1 = f + M2*(d0-f);
w1 = w0*sqrt(M2);
printf('z0/f = %f\n', z0/f);
printf('Magnification M=%f\n', sqrt(M2));
printf('location of the new waist = %f\n', d1);
printf('new waist w1 = %f\n', w1);
pause(2)

NS = 20;
dz = d1/(NS-1);

for z2=0:dz:2*d1
    [gp2]=Propagation(gp,L1,lambda,z2);
    gp2i = abs(gp2).^2;
    gp2il = gp2i( int32(M/2),:);
    ph = angle( gp2( int32(M/2),:) );
    ind = (gp2il/gp2il( int32(M/2)) < 1.e-3);
    ph(ind) = 0;
    ph = unwrap( ph );
    c = ph(int32(M/2));
    ph(ind) = c;
    
    subplot(2,3,4)
    imagesc(x1,x1, gp2i);
    axis square; axis xy;
    colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
    title(sprintf('z= %f mm', z2));
    
    subplot(2,3,5)
    plot(x1, gp2il );
    xlabel('x (mm)'); ylabel('Intensity')
    
    subplot(2,3,6)
    plot(x1, ph );
    xlabel('x (mm)'); ylabel('Phase')
    
    if abs(z2-d1) < dz      
        title('Beam Waist position')
        pause(2)
    else
        pause(0.05)
        title(' ')
    end
end

