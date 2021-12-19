% Hologram of a triangle object with plane reference wave
clc
clear all
format compact
global ah;

% Square Matrix dimension
Ndim = 512;
% Wave length in mm
lambda = 633.0e-6;

% Coordinates of the object center in mm:
zo = -200;

% tilt in degrees of the reference:
xtr = 20;
ytr = 45;

% tilt in degrees of the reconstruction:
xtre = 20;
ytre = 45;


% Sampling distance at the output plane in mm
Sampling = 0.01; 
Size = Sampling * Ndim;
zcrit = Size * Sampling / lambda;
disp(['Zcrit  : ' ,sprintf('%f',zcrit)])

% Triangle Object
Rec = triangleRect(20, 35, 512, 512);
Rec = circshift(Rec, [-128 -128]);
% Propagation from the object to the hologram plane
Po = FresnelIR(Rec,Size,lambda,-zo); %propagation
imax = max(max(abs(Po)))/4;

% Plane Wave Reference
Amplitude = imax;
Pr = Amplitude * TiltedPlaneWave(Ndim, lambda, xtr, ytr, Sampling);

% Plane Wave Reconstruction
Pre = TiltedPlaneWave(Ndim, lambda, xtre, ytre, Sampling);

% Irradiance at the hologram plane
%=====================================
Ir = abs(Po + Pr).^2;

figure(1)
subplot(1,3,1)
colormap(gray);
imagesc(Rec);
axis equal tight
title('Original Object')

subplot(1,3,3)
colormap(gray);
imagesc(angle(Po));
axis equal tight
title('Object Wave Phase at the Hologram')

subplot(1,3,2)
colormap(gray);
imagesc(abs(Po));
axis equal tight
title('Object Wave Magnitude at the Hologram')


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