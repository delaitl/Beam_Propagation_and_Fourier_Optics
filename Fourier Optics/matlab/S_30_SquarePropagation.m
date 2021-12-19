% Propagation of a square by using the different methods

clc
format compact

L1 = 20; %side length (mm)
M  = 256; %number of samples
lambda = 0.0005; %wavelength (mm)
k = 2*pi/lambda; %wavenumber
w = 1.1; %source half width (mm)

% Delta X (mm) in the source plane
dx1 = L1/M;
x1=-L1/2:dx1:L1/2-dx1; %src coords
y1=x1;

% Maximum distance z (mm)
zmax = L1 * dx1 / lambda;
dz = zmax/20;

[X1,Y1]=meshgrid(x1,y1);
u1=rect(X1/(2*w)).*rect(Y1/(2*w)); %src field
I1=abs(u1.^2); %src irradiance

% Source plane
figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
title('z= 0 m');

titulo = sprintf('Critical Distance :%f',zmax)
H=figure(2);
set(H,'Name',titulo)
% Propagation
for z=dz:dz:5*zmax
    
    lz = lambda*z/2;
    x2=x1*lz; %obs coords
    y2=y1*lz;
  
    AS=AngularSpectrum(u1,L1,lambda,z);
    I2=abs(AS).^2; %obs irrad
    figure(3) %display obs irrad
    title(titulo);
    imagesc(x1,y1,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title(['RSTF   z= ',num2str(z),' mm']);
        
    % Rayleigh–Sommerfeld Transfer Function Propagator
    %=================================================
    uRSTF = RaySomTF(u1,L1,lambda,z); %propagation FTF
    I2=abs(uRSTF).^2; %obs irrad
            
    figure(2) %display obs irrad
    title(titulo);
    subplot(2,2,1)
    imagesc(x1,y1,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title(['RSTF   z= ',num2str(z),' mm']);

    
    % Fresnel Transfer Function Propagator
    %==================================================
    uFTF=FresnelTF(u1,L1,lambda,z); %propagation FTF
    I2=abs(uFTF).^2; %obs irrad
    
    subplot(2,2,2)
    imagesc(x1,y1,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title(['FTF   z= ',num2str(z),' mm']);
    
    
    % Fresnel Impulse Response Propagator
    %==================================================
    uFIR=FresnelIR(u1,L1,lambda,z); %propagation FTF
    I2=abs(uFIR).^2; %obs irrad
    
    subplot(2,2,3)
    imagesc(x1,y1,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title(['FIR   z= ',num2str(z),' mm']);
    
    % Fresnel Fourier Transform Propagator
    %==================================================
    uFFT=FresnelFT(u1,L1,lambda,z);
    I2=abs(uFFT).^2; %obs irrad
    
    subplot(2,2,4)
    imagesc(x2,y2,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title(['FFT   z= ',num2str(z),' mm']);    
    
    if(abs(z-zmax) < dz)
        disp(['Critical Distance :' ,sprintf('%f',zmax)])
        input('press enter');
    end
    
    pause(0.5);
end