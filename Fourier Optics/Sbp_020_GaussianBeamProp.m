% Propagation of a Gaussian Beam
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

clc
format compact
clear all
global KK;

% Size and shampling at the source plane
L1 = 20; %side length (mm) of the image
M  = 256; %number of samples
lambda = 0.0005; %wavelength (mm)
k = 2*pi/lambda; %wavenumber
KK = k;

% Gaussian Definition at the beam waist
w0 = 1.1; %0.5; %1.1; %Gaussian with (mm)
z0 = k*w0^2/2;  % Rayleigh range

% Delta X (mm) in the source plane
dx1 = L1/M;
x1=-L1/2:dx1:L1/2-dx1; %src coords
[X1,Y1] = meshgrid(x1,x1);
R2 = X1.^2 + Y1.^2;

% Critial distance z (mm)
zmax = L1 * dx1 / lambda;
disp(zmax);

zpmax = input('maximum propagatio distance : ');
Nz = 200; % Number of displacements
dz = zpmax/(Nz-1);

% Gaussian function at the source plane
g = Gaussian_mm(w0, R2); % Amplitude
gi = g.^2; % Intensity

% Source plane
figure(1)
subplot(1,2,1)
imagesc(x1,x1,gi);
axis square; axis xy;
colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
title('z= 0 mm');

subplot(1,2,2)
plot(x1, gi( int32(M/2),:) );
xlabel('x (mm)'); ylabel('Intensity')

% Fitting Options
% options = optimoptions('lsqcurvefit','TolFun',1.0e-10,'MaxIter',1000);
p(1) = w0; % Initital Gaussian width
p(2)= 1; % Initial Intensity at 0

pah(1) = 0;
pah(2) = 1000;

% Propagation
%==========
for z=dz:dz:zpmax
    % Theoretical calculations
    w = w0*sqrt(1 + (z/z0)^2); % Beam radius
    it = (w0/w)^2 * exp(-2*x1.^2/w^2); % Intensity distribution
    Rt = z*(1+(z0/z)^2); %Phase Curvature Radius
    Phase = atan(z/z0) + k*x1.^2/(2*z*(1+(z0/z)^2)); % + k*z;
        
    % Numeric calculations
    [gp]=Propagation(g,L1,lambda,z);
    gpa = abs(gp); % modulus
    gpi = gpa.^2; % Intensity
    gpil = gpi( int32(M/2)+1,:); % Extraction of the central row
    ind = find(gpil <1.e-3); % Points with very los intensity
    
    ph  = angle(gp);  %Phase
    phl = ph( int32(M/2)+1,:); % Central row
    phl = unwrap( phl ); %Unwrap Phase
    of = phl(int32(M/2)+1) - Phase(int32(M/2)+1); % Offset betwee theoretical and numerical
    
    phl = phl - of; % Offset removal
    
    % The phase is made equal to 0
    phl(ind) = 0; % In points were the intensity is very low
    phl(1:20) = 0; % At initial points (to avoid aliasing)
    phl (M-20:M) = 0; % At points at the end (to avoid alising)
    ind2 = find(phl ~= 0);
    % The same with the teoretical phase
    Phase(ind) = 0;
    Phase(1:20) = 0;
    Phase (M-20:M) = 0;
    erph = 0.5 + Phase - phl; % Phase error + 0.5 to better visualize
    
    % Fitting the Gaussian modulus
    % pf = lsqcurvefit(@Gaussian_mf,  p, R2, gpa, [0 0], [1000 1000],options);
    pf = lsqcurvefit(@Gaussian_mf,  p, R2, gpa, [0 0], [1000 1000]);
    itf = (pf(2))^2 * exp(-2*x1.^2/pf(1)^2); % Intensity distribution
    p(1) = pf(1) ; % w
    p(2) = pf(2);
    % Fitting the Gaussian phase
    % pahf = lsqcurvefit(@Gaussian_Phasef,  pah, x1(ind2).^2, phl(ind2), [0 1.e-5], [2*pi 1.e10],options);
    pahf = lsqcurvefit(@Gaussian_Phasef,  pah, x1(ind2).^2, phl(ind2), [0 1.e-5], [2*pi 1.e10]);
    
    pah(1) = pahf(1);
    pah(2) = pahf(2);
    
    figure(2)
    subplot(1,3,1)
    imagesc(x1,x1,gpi);
    axis square; axis xy;
    colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
    title(sprintf('z= %f mm', z));
    
    subplot(1,3,2)
    plot(x1, gpil, 'b' );
    hold on
    plot(x1, it, 'r' ,'LineWidth',2);
    err = 0.5 + it - gpil;
    plot(x1, err, 'g' );
    plot(x1, itf, 'k' );
    hold off
    xlabel('x (mm)'); ylabel('Intensity')
    axis([-L1/2 L1/2 0 1]);
    legend('Numerical', 'Theory', '0.5+error','fitted');
    title(sprintf('Wt=%f  Wf=%f', w, pf(1)));
    
    subplot(1,3,3)
    plot(x1, phl, 'b' );
    hold on
    plot(x1, Phase, 'r' );
    plot(x1, erph, 'g' );
    hold off
    
    title(sprintf('Rt=%f  Rf=%f', Rt, pahf(2)));
    xlabel('x (mm)'); ylabel('Phase')
    legend('Numerical', 'Theory', '0.5+error');
    axis([-L1/2 L1/2 0 10]);
    
    pause(0.1);
end
