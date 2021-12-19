% Comparison of different Beam Propagation Methods
%
%In settings set Graphics options to:  fltk
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

clc
% close all
format compact

L1 = 20; %side length (mm) of the image
M  = 256; %number of samples
lambda = 0.0005; %wavelength (mm)
k = 2*pi/lambda; %wavenumber
w = 1.1; %Rectangle half width (mm)

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
  
    % Angular Spectrum Propagation
    %==================================
    AS=AngularSpectrum(u1,L1,lambda,z);
    I2=abs(AS).^2; %obs irrad
    
    subplot(2,2,1)
    imagesc(x1,y1,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    if z > zmax
        title(['ANSP   z= ',num2str(z),' mm'],'Color','r');
    else
        title(['ANSP   z= ',num2str(z),' mm'],'Color','k');
    end
            
  
    % Fresnel Impulse Response Propagator
    %==================================================
    uFIR=FresnelIR(u1,L1,lambda,z); %propagation FTF
    I2=abs(uFIR).^2; %obs irrad
    
    subplot(2,2,2)
    imagesc(x1,y1,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    if z > zmax
        title(['IR   z= ',num2str(z),' mm'],'Color','k');
    else
        title(['IR   z= ',num2str(z),' mm'],'Color','r');
    end
    
      
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
    
    % Combination of the two Propagators
    %==================================================
    uProp=Propagation(u1,L1,lambda,z);
    I2=abs(uProp).^2; %obs irrad
    
    subplot(2,2,3)
    imagesc(x2,y2,I2);
    axis square; axis xy;
    colormap('gray'); xlabel('x (m)'); ylabel('y (m)');
    title(['Combination Propagators   z= ',num2str(z),' mm']);    
    
    if(abs(z-zmax) < dz)
        disp(['Critical Distance :' ,sprintf('%f',zmax)])
        input('press enter');
    end
    
    pause(0.5);
end