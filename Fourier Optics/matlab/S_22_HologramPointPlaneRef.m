% Hologram of a 3 points object with plane reference wave
clc
format compact
global ah;

% Square Matrix dimension
Ndim = 512;
% Wave length in mm
lambda = 633.0e-6;

% Coordinates of the object center in mm:
xo = -1.0;
yo = -1.0;
zo = -200;

% tilt in degrees of the reference:
xtr = 15;
ytr = 0;

% tilt in degrees of the reconstruction:
xtre = 0;
ytre = 0;


% Sampling distance at the output plane in mm
Sampling = 0.01; 
Size = Sampling * Ndim;

% Spherical Wave Object
Po =      SphericalWave_Quadratic(Ndim, lambda, xo, yo, zo, Sampling);
Po = Po + SphericalWave_Quadratic(Ndim, lambda, xo+10*Sampling, yo, zo, Sampling);
Po = Po + SphericalWave_Quadratic(Ndim, lambda, xo, yo+15*Sampling, zo, Sampling);
imax = max(max(abs(Po)));

% Spherical Wave Reference
Amplitude = imax;
Pr = Amplitude * TiltedPlaneWave(Ndim, lambda, xtr, ytr, Sampling);

% Spherical Wave Reconstruction
Pre = TiltedPlaneWave(Ndim, lambda, xtre, ytre, Sampling);

% Irradiance at the hologram plane
%=====================================
Ir = abs(Po + Pr).^2;

figure(1)
subplot(1,3,1)
colormap(gray);
imagesc(angle(Po));
axis equal tight
title('Object Phase')

subplot(1,3,2)
colormap(gray);
imagesc(angle(Pr));
axis equal tight
title('Reference Phase')

subplot(1,3,3)
colormap(gray);
imagesc(angle(Pre));
axis equal tight
title('Reconstruction Phase')

figure(2)
subplot(1,3,1)
colormap(gray);
imagesc(Ir);
axis equal tight
title('Hologram')

% Transmitted amplitude
%=========================================
Out = Ir.*Pre;

figure(2)
subplot(1,3,2)
colormap(gray);
imagesc(angle(Out));
axis equal tight
title('Transmitted Phase')

subplot(1,3,3)
colormap(gray);
imagesc(abs(Out));
axis equal tight
title('Transmitted Amplitude')


%Propagation for reconstruction
%==============================

% Reconstruction distances
zi3 = -zo;  % Term 3
zi4 =  zo;  % Term 4

% Magnification
M3 =-(zi3/zo); % Term 3
M4 = (zi4/zo); % Term 4

disp(['Term 3 :' ,sprintf('%f',zi3), '   M = ',sprintf('%f',M3)])
disp(['Term 4 :' ,sprintf('%f',zi4), '   M = ',sprintf('%f',M4)])


d = zi3 - zi4;

delta = d/100;
d10 = delta*20;
dab = abs(delta);

% This call the function "wbmcb" when the mouse is moved in the figure
% The function write the coordinates of the mouse
h = figure('WindowButtonMotionFcn',@wbmcb);
ah = axes('DrawMode','fast');
        
for z=zi4-d10:delta:zi3+d10
    Rec=FresnelTF(Out,Size,lambda,z); %propagation
    
    titulo = sprintf ('Reconstructed Amplitude. Distance= %f', z);
    figure(h)
    % subplot(1,3,3)
    colormap(gray);
    imagesc(abs(Rec));
    axis equal tight
    title(titulo)
    if(abs(z-zi3) < dab)
        title(['Term 3 :  ' ,titulo])
        disp(['Term 3 :' ,sprintf('%f',zi3), '   M = ',sprintf('%f',M3)])
        input('press enter');
    end
    if(abs(z-zi4) < dab)
        title(['Term 4 :  ' ,titulo])
        disp(['Term 4 :' ,sprintf('%f',zi4), '   M = ',sprintf('%f',M4)])
        input('press enter');
    end

    
    wait(10000, 100);
end