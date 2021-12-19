% Digital Holography
clear all

lambda = 0.633; % WaveLength in microns
pixelS = 5;    % Sampling distance in microns

%Read the first image to be propagated
[filename, pathname] = ...
     uigetfile({'*.*';'*.bmp';'*.tif'},'Select the image');
 file1 = fullfile(pathname, filename);
img = imread(file1);
[N, M]  = size(img)
N2      = 2*N;
Nm      = N/2;
imagen = ones(N2,N2);
imagen(Nm:Nm+N-1, Nm:Nm+N-1) = img;

figure(1) 
imagesc(imagen); % Show the image 1
colormap(gray)
axis equal tight

%Read the second image to be propagated
[filename, pathname] = ...
     uigetfile({'*.*';'*.bmp';'*.tif'},'Select the image');
 file1 = fullfile(pathname, filename);
img = imread(file1);
imagen2 = ones(N2,N2);
imagen2(Nm:Nm+N-1, Nm:Nm+N-1) = img;

figure(1) 
subplot(1,2,1)
imagesc(imagen); % Show the image 1
colormap(gray)
axis equal tight
subplot(1,2,2)
imagesc(imagen2); % Show the image 2
colormap(gray)
axis equal tight

L = N2*pixelS;