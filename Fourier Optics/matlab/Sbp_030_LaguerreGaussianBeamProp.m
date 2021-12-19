% Propagation of an Laguerre-Gaussian Beam
%
%In settings set Graphics options to:  fltk
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/


clc
format compact
clear all

% Size and shampling at the source plane
L1 = 20; %side length (mm) of the image
M  = 256; %number of samples
lambda = 0.0005; %wavelength (mm)
k = 2*pi/lambda; %wavenumber

% Gaussian Definition at the beam waist
w0 = 1.1; %Gaussian with (mm)
z0 = k*w0^2/2;  % Rayleigh range


% Delta X (mm) in the source plane
dx1 = L1/M;
x1=-L1/2:dx1:L1/2-dx1; %src coords
x2 = x1.^2;
% Critial distance z (mm)
zmax = L1 * dx1 / lambda;
disp(zmax);

zpmax = input('maximum propagatio distance : ');
Nz = 100;
dz = zpmax/(Nz-1);

% Gaussian function at the source plane
g = Gaussian_mm(x1, w0);

% Hermite Polynomials
[X,Y] = meshgrid(x1,x1);
R2 = X.^2 + Y.^2;
nl = 2; % Order
L = Laguerre0_6(2/(w0.^2)*R2, nl);
% Hx = hermiteH(nl, sqrt(2)/w0*X);

g = g .* L;
gi = g.^2;


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


%% Propagation
for z=0:dz:zpmax
    % Theoretical calculations
    w = w0*sqrt(1 + (z/z0)^2); % Beam radius
    LT = Laguerre0_6(2/(w.^2)*x2, nl);
    it = (w0/w)^2 * exp(-2*x1.^2/w^2) .* LT.^2; % Intensity distribution
    %it = (w0/w)^2 * exp(-2*x1.^2/w^2) .* hermiteH(nl, sqrt(2)/w*x1).^2; % Intensity distribution
    Phase = -(2*nl+1)*atan(z/z0) + k*x2/(2*z*(1+(z0/z)^2)); % + k*z;
    ind = find(LT<0);
    Phase(ind) = Phase(ind) - pi;
        
    % Numeric calculations
    [gp]=Propagation(g,L1,lambda,z);
    gpi = abs(gp).^2;
    gpil = gpi( int32(M/2),:);
    ind = find(gpil <1.e-3);
    
    [Ma,in] = max(gpil);
    fac = Ma/it(in);
    it = it*fac;
    
    
    ph  = angle(gp);
    phl = ph( int32(M/2),:);
    phl = unwrap( phl );
    of = phl(in) - Phase(in);  
    phl = phl - of;
%    for ii = 1:2
%     for k=1:M-1
%         if (Phase(k)-phl(k)) > pi
%             phl(k) = phl(k) + 2*pi;
%         elseif(Phase(k)-phl(k)) < -pi
%             phl(k) = phl(k) - 2*pi;
%         end
%     end
%    end

    
    phl(ind) = 0;
    phl(1:20) = 0;
    phl (M-20:M) = 0;
    
    Phase(ind) = 0;
    Phase(1:20) = 0;
    Phase (M-20:M) = 0;
    erph = 0.5 + Phase - phl;
    
    
    
    figure(2)
    subplot(1,3,1)
    imagesc(x1,x1,gpi);
    axis square; axis xy;
    colormap('gray'); xlabel('x (mm)'); ylabel('y (mm)');
    title(sprintf('z= %f mm', z));
    
    subplot(1,3,2)
    plot(x1, gpil, 'b' );
    hold on
    plot(x1, it, 'r' );
    err = 0.5 + it - gpil;
    plot(x1, err, 'g' );
    hold off
    xlabel('x (mm)'); ylabel('Intensity');
    %axis([-L1/2 L1/2 0 1]);
     legend('Numerical', 'Theory', '0.5+error');
        
    subplot(1,3,3)
    plot(x1, phl, 'b' );
    hold on
    plot(x1, Phase, 'r' );
    plot(x1, erph, 'g' );
    hold off
    
    xlabel('x (mm)'); ylabel('Phase')
     legend('Numerical', 'Theory', '0.5+error');
%     axis([-L1/2 L1/2 0 10]);
    
    pause(0.1);
end
