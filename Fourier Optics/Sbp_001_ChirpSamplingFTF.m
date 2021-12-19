% Fresnel Transfer Function
% Chirp Sampling
%
%In settings set Graphics options to:  fltk
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

clc
format compact
clear all

L  = 20; %side length (mm)
M  = 250; %number of samples
lambda = 0.5*10^-3; %wavelength (mm)

% Delta X (mm)
dx = L/250;
% Maximum distance z (mm)
zmax = L * dx / lambda;

dz = 2*zmax/50;

titulo = sprintf('Critical Distance :%f',zmax)
H=figure(3);
set(H,'Name',titulo) 

for z=0:dz:2*zmax
    H = ChirpFresnelTF(M, L,lambda,z);
    phase = angle(H);
    
    h = ifft2shift(H);
    hab = abs(h);
    hab = hab/max(max(hab));
    hab(1,1) = 0;
    
    figure(3)
    subplot(1,2,1)
    titulo = sprintf ('Chirp Phase FTF. Distance= %f', z);    
    colormap(gray);
    imagesc(phase);
    axis equal tight
    if z > zmax
        title(titulo, 'Color','r');
    else
        title(titulo, 'Color','k');
    end
    
    subplot(1,2,2)
    colormap(gray);
    imagesc(hab);
    axis equal tight
    title('magnitude FT')
     
    if(abs(z-zmax) < dz)
        disp(['Critical Distance :' ,sprintf('%f',zmax)])
        input('press enter');
    end    
    
    pause(0.2)
end

%% ==================================
% Fresnel Impulse Response
% Chirp Sampling
titulo = sprintf('Critical Distance :%f',zmax)
H=figure(4);
set(H,'Name',titulo) 
for z=dz:dz:2*zmax
    H = ChirpFresnelIR(M, L,lambda,z);
    phase = angle(H);
    
    h = ifft2shift(H);
    hab = abs(h);
    hab = hab/max(max(hab));
    hab(1,1) = 0;
    
    figure(4)
    subplot(1,2,1)
    titulo = sprintf ('Chirp Phase FIR. Distance= %f', z);    
    colormap(gray);
    imagesc(phase);
    axis equal tight
    if z < zmax
        title(titulo, 'Color','r');
    else
        title(titulo, 'Color','k');
    end
    
    subplot(1,2,2)
    colormap(gray);
    imagesc(hab);
    axis equal tight
    title('magnitude FT')
     
    if(abs(z-zmax) < dz)
        disp(['Critical Distance :' ,sprintf('%f',zmax)])
        input('press enter');
    end    
    
    pause(0.2)
end