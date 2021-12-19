% Phase Contrast

clc;    % Clean Command Window.
clear ; % Clean Memory
format compact
warning('off');

% Read Original image
mv = imread('Einstein.tif');
mv = double(mv);

% Make the dimensions even
[ny nx] = size(mv)
mv = mv(1:ny-1, :);
[ny nx] = size(mv)

vmax = max(max(mv));

% Construct a Phase image
ec = exp(1i*pi*mv/vmax);

figure(1)
subplot(2,2,1)
colormap(gray);
imagesc(mv);
title('Original Image')
axis equal tight

subplot(2,2,3)
colormap(gray);
imagesc(abs(ec));
axis equal tight
title('Magnitude of the Phase Image')

subplot(2,2,4)
colormap(gray);
imagesc(angle(ec));
axis equal tight
title('Phase of the Phase Image')

EC = fft2shift(ec);
[ny nx] = size(EC);

% Change the Phase at the origin
Phase = pi/2.0;
EC(floor(ny/2)+1, floor(nx/2)+1) = EC(floor(ny/2)+1, floor(nx/2)+1) * exp(1i*Phase);


ecf = ifft2shift(EC);

subplot(2,2,2)
colormap(gray);
imagesc(abs(ecf));
axis equal tight
title('Magnitude of the Filtered Phase Image')

