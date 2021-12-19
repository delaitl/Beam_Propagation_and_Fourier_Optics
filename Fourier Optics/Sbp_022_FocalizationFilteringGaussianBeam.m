% Focalization and filtering of a Gaussian Beam
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

clc
clf
%close all
format compact

% Size and shampling at the source plane
L1 = 20; %side length (mm) of the image
M  = 1024; %number of samples
lambda = 0.0005; %wavelength (mm)
k = 2*pi/lambda; %wavenumber

% Gaussian Definition at the beam waist
w0 = 0.5; %Gaussian with (mm)
z0 = k*w0^2/2;  % Rayleigh range
fprintf('z0=%f \n', z0);

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
ind = find(g<1.e-3);
M2 = int32(M/2);
g( M2-1:M2+1,:) = 0;
g(:,M2-1:M2+1) = 0;
g = g + 0.5*rand(M,M);
g(ind) = 0;

gi = g.^2;

% figure(10)
% imagesc(gi);

% Source plane
figure(1)
imagesc(x1,x1,gi);
axis square; axis xy;
colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
title('z= 0 mm');


% Lens definition
f = 1000; % Focal length of the lens in mm
d0 = 1000; % Location of the beam waist in mm
Lens = exp(-1i*LensPhase(x1, lambda, f) );


%% Propagation and pass through the lens
[gp]=Propagation(g,L1,lambda,d0);  % Propagation
gp = gp.*Lens; % Passing the lens

%% Propagation to the new waist
M2 = f*f / ((d0-f)^2 + z0^2);
d1 = f + M2*(d0-f);
w1 = w0*sqrt(M2);
fprintf('z0/f = %f\n', z0/f);
fprintf('Magnification M=%f\n', sqrt(M2));
fprintf('location of the new waist = %f\n', d1);
fprintf('new waist w1 = %f  in pixels=%f\n', w1, w1/dx1);
pause(2)

R = w1/dx1;
R = 32;
CA = CircularAperture(M, R); 
NS = 20;
dz = d1/(NS-1);
wa = 0;
for z2=0:dz:2.5*d1
    [gp2]=Propagation(gp,L1,lambda,z2);
    gp2i = abs(gp2).^2;
       
    figure(2)
    subplot(1,2,1)
    imagesc(x1,x1, sqrt(gp2i));
    axis square; axis xy;
    colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
    title(sprintf('z= %f mm', z2));
    
    if wa == 1
        [gpfp]=Propagation(gpf,L1,lambda,z2-zz);
        subplot(1,2,2)
        imagesc(x1,x1, sqrt(abs(gpfp).^2));
        axis square; axis xy;
        colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
        title(sprintf('Filtered z= %f mm', z2));
    end

    
    if abs(z2-d1) < 2*dz/3      
        title('Beam Waist position')
        gpf = gp2.*CA;
        wa = 1;
        zz = z2;
        pause(2)
    else
        pause(0.05)
    end
end



