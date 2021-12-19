clc;    %Clear the cpommand Window.
clear ; %Clear the memory
format compact
warning('off');

% Read the image
f = imread('Lenstarg_25_5906p_15g_0is.png');


H = figure(1);
set(H,'Name','Resolution test')
% subplot(3,3,1)
colormap(gray);
imagesc(f);
axis equal tight