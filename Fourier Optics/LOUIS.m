%This code creates a Computer Generated Hologram (CGH) and then reconstruct the
%original images by Computer Hologram Reconstruction.
clear all

lambda = 0.633; % WaveLength in microns
pixelS = 5;    % Sampling distance in microns
z = 12000; %distance of propagation 12 mm
A = 0.1; %noise max amplitudeon the intensity 

%Read the first image to be propagated and introduce it in a larger matrix
%made of 1 : imagen
img = imread("letras1.bmp");
[N, M]  = size(img);
N2      = 2*N;
Nm      = N/2;
imagen = ones(N2,N2);
imagen(Nm:Nm+N-1, Nm:Nm+N-1) = img;

%Read the second image to be propagated and introduce it in a larger matrix
%made of 1 : imagen2
img = imread("letras2.bmp");
imagen2 = ones(N2,N2);
imagen2(Nm:Nm+N-1, Nm:Nm+N-1) = img;

% show the 2 images
figure(1) 
subplot(1,2,1)
imagesc(imagen); % Show the image 1
colormap(gray)
axis equal tight
subplot(1,2,2)
imagesc(imagen2); % Show the image 2
colormap(gray)
axis equal tight
sgtitle('original images')

L = N2*pixelS; % dimension of the source and plane side

%%% Step 1 : propagation  of the light through a distance d
u1p = Propagation(imagen,L,lambda,z);

%%% Step 2 : Multiplication of the first image propagated and the second
u2 = u1p .* imagen2;

%%% Step 3 : propagation  of the light through a distance d
u2p = Propagation(u2,L,lambda,z);

%%% On-Axis Phase Shifting Holography
%%% Evaluation of 4 interferograms with different phase alpha
%%% with noise and displaying of the images captured by the CCD

% alpha = 0
    k = 0;
    alpha = pi/2 *k;
    %noise creation
    n = A*(rand(N2,N2)-0.5);
    %Intensity computing
    I0 = (abs(u2p + exp(1j*alpha))).^2 + n;


% alpha = pi/2
    k = 1;
    alpha = pi/2 *k;
    %noise creation
    n = A*(rand(N2,N2)-0.5);
    %Intensity computing
    I1 = (abs(u2p + exp(1j*alpha))).^2 + n;
    

% alpha = pi
    k = 2;
    alpha = pi/2 *k;
    %noise creation
    n = A*(rand(N2,N2)-0.5);
    %Intensity computing
    I2 = (abs(u2p + exp(1j*alpha))).^2 + n;

    

% alpha = 3pi/2
    k = 3;
    alpha = pi/2 *k;
    %noise creation
    n = A*(rand(N2,N2)-0.5);
    %Intensity computing
    I3 = (abs(u2p + exp(1j*alpha))).^2 + n;

    
    
    figure(2)
    subplot(2,2,1)
    imagesc(I0);
    title('I0')
    colormap(gray)
    axis equal tight
    
    subplot(2,2,2)
    imagesc(I1);
    title('I1')
    colormap(gray)
    axis equal tight
    
    subplot(2,2,3)
    imagesc(I2);
    title('I2')
    colormap(gray)
    axis equal tight
    
    subplot(2,2,4)
    imagesc(I3);
    title('I3')
    colormap(gray)
    axis equal tight

%%% Phase and Amplitude evaluation and displaying
Complex = 1j*(I1-I3)+(I0-I2);
Phase = angle(Complex);
Amplitude = abs(Complex);
% show the 2 images
figure(3) 
subplot(1,2,1)
imagesc(Phase); % Show the Phase
title('reconstructed Phase')
colormap(gray)
axis equal tight
subplot(1,2,2)
imagesc(Amplitude); % Show the Amplitude
title('reconstructed Amplitude')
colormap(gray)
axis equal tight


%%% 50 small propagation steps and displaying of 
%%% the absolute value in each step.
%%% When you are at step 25 the pause is longer (pause(2)).
u_in = Amplitude.*exp(1j*Phase);
 for zz=1:50
      u_out = Propagation(u_in,L,lambda,-2*z/50);
        
        figure(4)
        imagesc(abs(u_out));
        title('back propagation image')
        colormap(gray)
        axis equal tight

      if(zz==25)
        pause(2);
      else
        pause(0.1);
      end
      u_in = u_out;

 end