% S_Test_BinaryFilters1.m
% Fourier Domain Filtering with Binary Filters

%Clear all memory
clear all
clc

% Image dimensions
DimX = 256;
DimY = DimX;

% Periodic functions
%=====================================

% 2 Sinusoidal functions
    % Functions
    Periodo = 32;
    Tilt = 0;
    L = TiltedSin(DimX, DimY, Periodo, Tilt);
    Tilt = 90;
    L = L + circshift(TiltedSin(DimX, DimY, Periodo, Tilt), [16 0]);

    % Draw the function
    H=figure(1);
    set(H,'Name','Sinusoidal Filters')
    subplot(3,3,1)
    colormap(gray);
    imagesc(L);
    axis equal tight
    title('Addition of Sinusoids')
    
    subplot(3,3,3)
    plot(L(:,int32(DimX/2)),'r');
    hold on
    plot(L(DimY/2, :),'b');    
    axis([1 DimX -1 1]);
    legend('Column', 'Row');
    hold off
    
    % Fourier Transform
    TFL = fft2shift(L);
    % Absolute value
    Modulo = abs(TFL);
    subplot(3,3,2)
    colormap(gray);
    imagesc(Modulo);
    axis equal tight
    title('Absolute value FT Addition of 2 sinusoids')
    
    % Filtring in one dimension
    % Width of the filter
    ancho = 5;
    TFL1 = TFL;
    TFL1(1:DimY/2-ancho/2,:) = 0;
    TFL1(DimY/2+ancho/2:DimY,:) = 0;
    Modulo = abs(TFL1);
    subplot(3,3,5)
    colormap(gray);
    imagesc(Modulo);
    axis equal tight
    title('Absolute value of the filtered FT Addition of 2 sinusoids')
    
    % Inverse FT
    L1 = ifft2shift(TFL1);
    Preal = real(L1);
    subplot(3,3,6)
    colormap(gray);
    imagesc(Preal);
    axis equal tight
    title('Filtered addition')
    
    subplot(3,3,4)
    plot(Preal(:,int32(DimX/2)),'r');
    hold on
    plot(Preal(DimY/2, :),'b');
    axis([1 DimX -1 1]);
    legend('columna', 'fila');
    hold off
    
    
    % Filtering in the other direction
    %Filter width
    ancho = 5;
    TFL2 = TFL;
    TFL2(:, 1:DimX/2-ancho/2) = 0;
    TFL2(:, DimX/2+ancho/2:DimX) = 0;
    Modulo = abs(TFL2);
    subplot(3,3,8)
    colormap(gray);
    imagesc(Modulo);
    axis equal tight
    title('Absolute value of the filtered FT Addition of 2 sinusoids')
    
    % inverse FT
    L2 = ifft2shift(TFL2);
    Preal = real(L2);
    subplot(3,3,9)
    colormap(gray);
    imagesc(Preal);
    axis equal tight
    title('Filtered image')
    
    subplot(3,3,7)
    plot(Preal(:,int32(DimX/2)),'r');
    hold on
    plot(Preal(DimY/2, :),'b');    
    axis([1 DimX -1 1]);
    legend('Row', 'Column');
    hold off
    
 % 2D Grating of Square functions
 DimX = 128;
 DimY = DimX;
    ancho = 16;
    a = ancho-1;
    p     = 32;
    c = ones(ancho, ancho);
    
    L = zeros(DimX, DimX);
    
    for y=1:p:DimX-ancho
        for x=1:p:DimX-ancho
            L(y:y+a, x:x+a) = c;
        end
    end

    % Draw
    H=figure(2);
    set(H,'Name','2D Grating of Square Functions')
    subplot(3,3,1)
    colormap(gray);
    imagesc(L);
    axis equal tight
    title('Cuadrados')
    
    
    % FT
    TFL = fft2shift(L);
    % Magnitude draw
    Modulo = abs(TFL);
    subplot(3,3,2)
    colormap(gray);
    imagesc(log10(1+Modulo));
    axis equal tight
    title('Magnitude of the FT 2D Grating Squares')
    
    % Filtering in one direction
    % Filter width
    ancho = 5;
    TFL1 = TFL;
    TFL1(1:DimY/2-ancho/2,:) = 0;
    TFL1(DimY/2+ancho/2:DimY,:) = 0;
    Modulo = abs(TFL1);
    subplot(3,3,5)
    colormap(gray);
    imagesc(log10(1+Modulo));
    axis equal tight
    title('Módulo de la TF Cuadrados Filtrada')
    
    % Inverse FT
    L1 = ifft2shift(TFL1);
    Preal = real(L1);
    subplot(3,3,6)
    colormap(gray);
    imagesc(Preal);
    axis equal tight
    title('Filtered squares')
    
    subplot(3,3,4)
    plot(Preal(:,int32(DimX/2)),'r');
    hold on
    plot(Preal(DimY/2, :),'b');
    axis([1 DimX -1 1]);
    legend('row', 'column');
    hold off
    
    
    % Filtering in the other direction
    % Filter width
    ancho = 5;
    TFL2 = TFL;
    TFL2(:, 1:DimX/2-ancho/2) = 0;
    TFL2(:, DimX/2+ancho/2:DimX) = 0;
    Modulo = abs(TFL2);
    subplot(3,3,8)
    colormap(gray);
    imagesc(log10(1+Modulo));
    axis equal tight
    title('Magnitude filtered FT Grating of squares')
    
    % Inverse FT
    L2 = ifft2shift(TFL2);
    Preal = real(L2);
    subplot(3,3,9)
    colormap(gray);
    imagesc(Preal);
    axis equal tight
    title('Filtered squares')
    
    subplot(3,3,7)
    plot(Preal(:,int32(DimX/2)),'r');
    hold on
    plot(Preal(DimY/2, :),'b');    
    axis([1 DimX -1 1]);
    legend('row', 'column');
    hold off
    
