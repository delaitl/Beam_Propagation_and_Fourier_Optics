% Test Siemens

Dim = 512;
N   = 64;

% Siemens Star
Siemens = SiemensStar(Dim, N, 0);
H=figure(1);
set(H,'Name','Multiplication in the spatial domain')
subplot(3,3,1)
colormap(gray);
imagesc(Siemens);
axis equal tight

% TF and Draw
TFB = fft2shift(Siemens);
subplot(3,3,2)
colormap(gray);
imagesc(log(100+ abs(TFB)) );
title('Real FT Siemens')
axis equal tight

% Circular aperture
Rad = 192;
CA = CircularAperture(Dim, Rad);
subplot(3,3,6)
colormap(gray);
imagesc(CA );
title('Circular Aperture')
axis equal tight

% Multiplication Siemens Star and Circular aperture
S2 = Siemens.*CA;
TFS2 = fft2shift(S2);
subplot(3,3,4)
colormap(gray);
imagesc(S2 );
title('Siemens * Circular Aperture')
axis equal tight
subplot(3,3,5)
colormap(gray);
%imagesc(real(TFS2) +min(min(real(TFS2))) );
imagesc(log(100+ abs(TFS2)) );
title('Real FT Siemens * CA')
axis equal tight

% Circular Stop
CA = abs(CA - 1);
subplot(3,3,9)
colormap(gray);
imagesc(CA );
title('Circular Obstruction')
axis equal tight
S2 = Siemens.*CA;
TFS2 = fft2shift(S2);
subplot(3,3,7)
colormap(gray);
imagesc(S2 );
title('Siemens * Circular obstruction')
axis equal tight
subplot(3,3,8)
colormap(gray);
%imagesc(real(TFS2) +min(min(real(TFS2))) );
imagesc(log(100+ abs(TFS2)) );
title('Real FT Siemens * CO')
axis equal tight


%%================================================
% Multiplication in the Fourier Domain
%%================================================
clear all
clc
Dim = 512;
N = 64;
% Generación y dibujo de la estrella de Siemens
Siemens = SiemensStar(Dim, N, 0);
H=figure(2);
set(H,'Name','Multiplicacion en el dominio de Fourier')
subplot(3,3,1)
colormap(gray);
imagesc(Siemens);
axis equal tight
% TF y dibujo
TFB = fft2shift(Siemens);
subplot(3,3,2)
colormap(gray);
imagesc(log(100+ abs(TFB)) );
title('Real FT Siemens')
axis equal tight
% Generación de una apertura circular y dibujo
Rad = 70;
CA = CircularAperture(Dim, Rad);
subplot(3,3,4)
colormap(gray);
imagesc(CA );
title('Circular Aperture')
axis equal tight
subplot(3,3,5)
colormap(gray);
imagesc(log(100+ abs(TFB.*CA)) );
title('Real FT Siemens * CA')
axis equal tight
S2 = ifft2shift(TFB.*CA);
subplot(3,3,6)
colormap(gray);
imagesc(real(S2) );
title('Real IFT(FT Siemens * CA)')
axis equal tight
CA = abs(CA - 1);
subplot(3,3,7)
colormap(gray);
imagesc(CA );
title('Circular Obsturction')
axis equal tight
subplot(3,3,8)
colormap(gray);
imagesc(log(100+ abs(TFB.*CA)) );
title('Real FT Siemens * (1-CA)')
axis equal tight
S2 = ifft2shift(TFB.*CA);
subplot(3,3,9)
colormap(gray);
imagesc(real(S2) );
title('Real IFT(FT Siemens * (1-CA))')
axis equal tight