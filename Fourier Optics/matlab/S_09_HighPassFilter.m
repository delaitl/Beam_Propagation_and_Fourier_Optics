% High Pass Filter

clc;    %Clear the cpommand Window.
clear ; %Clear the memory
format compact
warning('off');

% Read the image
f = imread('Einstein.tif');
% Selection of a square part
f = f(1:512,1:512);
s = size(f) % size of the image


L = 1 - Gausiana(512, 512, 64);

H = figure(1);
set(H,'Name','High Pass Filter')
subplot(3,3,1)
colormap(gray);
imagesc(f);
axis equal tight

F = fft2shift(f);
subplot(3,3,2)
colormap(gray);
imagesc(log(100+ abs(F)) );
title('log abs TF')
axis equal tight

subplot(3,3,4)
colormap(gray);
imagesc(L);
title('HP filter')
axis equal tight

FL = F.*L;
subplot(3,3,5)
colormap(gray);
imagesc(log(100+ abs(FL)) );
title('log abs TF F*HPF')
axis equal tight

fl = ifft2shift(FL);
subplot(3,3,6)
colormap(gray);
imagesc(real(fl));
title('Filtered image')
axis equal tight


% Phase Filter


FL = F./abs(F);
subplot(3,3,8)
colormap(gray);
imagesc(log(100+ abs(FL)) );
title('log abs TF F*HPF')
axis equal tight

fl = ifft2shift(FL);
subplot(3,3,9)
colormap(gray);
imagesc(real(fl));
title('Filtered image')
axis equal tight
