% Convolution of the Siemens Star Test with circle
% Equivalent to a low pass filter

Dim = 512;
N   = 64;

% Siemens Star Test
Siemens = SiemensStar(Dim, N, 0);
figure(1)
colormap(gray); 
imagesc(Siemens);
title('Siemens Star')
axis equal tight



% Circular aperture
Rad = 2;
CA = CircularAperture(Dim, Rad);

figure(2)
subplot(2,2,1)
colormap(gray);
imagesc(CA );
title('Circular Aperture r=2')
axis equal tight

c = Convolucion(Siemens, CA, 'r');

subplot(2,2,2)
colormap(gray);
imagesc(c );
title('Siemens Star  Convolved with Circular Aperture r=2')
axis equal tight


% Circular aperture
Rad = 4;
CA = CircularAperture(Dim, Rad);

subplot(2,2,3)
colormap(gray);
imagesc(CA );
title('Circular Aperture r=4')
axis equal tight

c = Convolucion(Siemens, CA, 'r');

subplot(2,2,4)
colormap(gray);
imagesc(c );
title('Siemens Star  Convolved with Circular Aperture r=4')
axis equal tight
