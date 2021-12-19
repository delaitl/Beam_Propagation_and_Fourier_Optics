% S_Test_BinaryFilters.m
% Fourier Domain Filtering with Binary Filters
clc
format compact

Dim = 256;
PeriodoX = 32;
PeriodoY = 64;
rad      = 32;
Ax = 1;
Ay = 1;

%Function Generation: addition of two sinusoid functions
f = input('select function:  1 = 2 sinusoids;    2 = circle : ');
if( f == 1)
    L = 2 + SumaSenos(Dim, Dim, PeriodoX, PeriodoY, Ax, Ay);
else
    L = CircularAperture(Dim, rad);
end
mean(mean(L))

figure(1)
colormap(gray);
imagesc(L);
axis equal tight;
if( f == 1)
    title('2 + 2 sinusoids')
else
    title('circle')
end

% Fourier Transform
TFL = fft2shift(L);
figure(2)
colormap(gray);
%imagesc(log(10+ abs(TFL)) );
imagesc(abs(TFL) );
axis equal tight
if( f == 1)
    title('TF  2 + 2 sinusoids')
else
    title('TF  circle')
end


% Filter 1: FT at the origin = 0
%=========================================
TFL0 = TFL;
TFL0(Dim/2 + 1, Dim/2 + 1) = 0;
figure(3)
colormap(gray);
%imagesc(log(10+ abs(TFL)) );
imagesc(abs(TFL0) );
axis equal tight
if( f == 1)
    title('TF (2 +  2 sinusoids) 0 at the origin')
else
    title('TF (circle) 0 at the origin')
end

%Inverse FT to see the result in the space domain
L0 = ifft2shift(TFL0);
figure(4)
colormap(gray);
imagesc(real(L0) );
title('Real part')
axis equal tight

mean(mean(L0))

% Modulus square of the filtred function
figure(5)
colormap(gray);
imagesc(L.^2 );
title('Original ^2')
axis equal tight

figure(6)
colormap(gray);
imagesc(abs(L0).^2);
title('Filtered ^2')
axis equal tight

% Filter 2:FT along y axis equal to 0 
% horizontal zero frequency is removed
%======================================
TFLH = TFL;
TFLH(1:Dim/2, :) = 0;
TFLH(Dim/2+2:Dim, :) = 0;
L0 = ifft2shift(TFLH);

figure(7)
colormap(gray);
imagesc(real(L0) );
title('Horizontal filtering')
axis equal tight


% Phase object
%===============
LP = exp(1i*L);

figure(8)
colormap(gray);
imagesc(abs(LP).^2 );
title('Phase object')
axis equal tight

FTLP = fft2shift(LP);

% Filter 3: Phase of the 0 frequency is changed
%===============================================
FTLP(Dim/2+1, Dim/2+1) = FTLP(Dim/2+1, Dim/2+1)*exp(1i*pi);

LPF = ifft2shift(FTLP);

figure(9)
colormap(gray);
imagesc(abs(LPF).^2 );
title('Filtered phase object')
axis equal tight

