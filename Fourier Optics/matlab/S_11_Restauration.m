% Script restauracion
% Restauration of an image degraded with a low pass filter
% by applying the inverse filter


clc;    % Clean Command Window.
clear ; % Clean Memory
format compact
warning('off');

% Read the image
f = imread('Einstein.tif');
% Selection of a square part
f = f(1:512,1:512);
s = size(f); % size of the image

max(max(f))

n=0;

d = 1;
cte = 1.e-12;
% Convolution with gaussians and Inverse Filtering
for k=1:3
    %Show Image
    n = n+1;
    H=figure(n);
    set(H,'Name','Reconstruction with Inverse Filter')
    subplot(3,3,1)
    imagesc(f);
    axis equal tight

    % TF y dibujo
    F = fft2shift(f);
    subplot(3,3,4)
    colormap(gray);
    imagesc(log(100+ abs(F)) );
    title('log abs TF')
    axis equal tight


    % Función gaussiana de lado
    d = d*2;
    r = Gausiana(s(2), s(1), d);
    subplot(3,3,2)
    imagesc(r);
    titulo = sprintf('Gaussian width %d', 2*d+1);
    title(titulo)
    axis equal tight

    % TF y dibujo
    R = fft2shift(r);
    subplot(3,3,5)
    colormap(gray);
    imagesc(log(100+ abs(R)) );
    title('log abs TF')
    axis equal tight

    c = Convolucion(f, r, 'r');
    subplot(3,3,3)
    colormap(gray);
    imagesc(c );
    title('Convolution with gaussian')
    axis equal tight

    % TF y dibujo
    C = fft2shift(c);
    subplot(3,3,6)
    colormap(gray);
    imagesc(log(100+ abs(C)) );
    title('log abs TF Convolution with gaussian')
    axis equal tight
    
    %====================================================
    % Restuaration assuming that the degradation in known
    %====================================================
    
    % Inverse Filter
    RI = conj(R)./(cte + abs(R).^2);
    subplot(3,3,8)
    colormap(gray);
    imagesc(log(100+ abs(RI)) );
    title('Inverse Filter (Log abs)')
    axis equal tight
    
    % Multiplication Inverse FIlter * FT degraded image
    CI = C.*RI;
    subplot(3,3,9)
    colormap(gray);
    imagesc(log(100+ abs(CI)) );
    title('log abs TF degraded Image * Inverse Filter')
    axis equal tight
    
    % Imagen reconstruida
    CR = ifft2shift(CI);
    subplot(3,3,7)
    colormap(gray);
    imagesc(real(CR) );
    title('Real Part Reconstructed Image')
    axis equal tight
    
    
end

d = 1;
cte = 1.e-4;
AmpliNoise = 1;
Noise = AmpliNoise * 2 * (rand(512,512)-0.5);
% Convolution with gaussians and Inverse Filtering
% Noisy images
for k=1:3
    %Show Image
    n = n+1;
    H=figure(n);
    set(H,'Name','Reconstruction with Inverse Filter. Noisy Image')
    subplot(3,3,1)
    imagesc(f);
    axis equal tight

    % TF y dibujo
    F = fft2shift(f);
    subplot(3,3,4)
    colormap(gray);
    imagesc(log(100+ abs(F)) );
    title('log abs TF')
    axis equal tight


    % Función gaussiana de lado
    d = d*2;
    r = Gausiana(s(2), s(1), d);
    subplot(3,3,2)
    imagesc(r);
    titulo = sprintf('Gaussiana width %d', 2*d+1);
    title(titulo)
    axis equal tight

    % TF y dibujo
    R = fft2shift(r);
    subplot(3,3,5)
    colormap(gray);
    imagesc(log(100+ abs(R)) );
    title('log abs TF')
    axis equal tight

    c = Convolucion(f, r, 'r');
    c = c + Noise;
    subplot(3,3,3)
    colormap(gray);
    imagesc(c );
    title('Convolution with gaussian + noise')
    axis equal tight

    % TF y dibujo
    C = fft2shift(c);
    subplot(3,3,6)
    colormap(gray);
    imagesc(log(100+ abs(C)) );
    title('log abs TF Convolution with gaussian + noise')
    axis equal tight
    
    %====================================================
    % Restuaración supuesto conocida la degradacion
    %====================================================
    
    % Inverse Filter
    RI = conj(R)./(cte + abs(R).^2);
    subplot(3,3,8)
    colormap(gray);
    imagesc(log(100+ abs(RI)) );
    title('Inverse Filter (Log abs)')
    axis equal tight
    
    % Multiplication Inverse FIlter * FT degraded image
    CI = C.*RI;
    subplot(3,3,9)
    colormap(gray);
    imagesc(log(100+ abs(CI)) );
    title('log abs TF degraded Image * Inverse Filter')
    axis equal tight
    
    % Reconstructed Image
    CR = ifft2shift(CI);
    subplot(3,3,7)
    colormap(gray);
    imagesc(real(CR) );
    title('Real Part reconstructed Image')
    axis equal tight
    
    
end

