% Script Convolución
% Realiza la convolución de una imagen y una función rectangular o gausiana. 
% Se observa el filtrado equivalente pasa-baja

clc;    %Limpia la ventana de comandos.
clear ; %Limpia las variables en la memoria
format compact
warning('off');

% Lee la imagen
f = imread('Einstein.tif');
% Seleccionamos una parte de la imagen
f = f(1:512,1:512);
s = size(f) % size of the image

n=0;
d = 1;
% Convoluciones con cuadrados
for k=1:3
    %Show Image
    n = n+1;
    H=figure(n);
    set(H,'Name','Filtrado por convolucióncon un cuadrado: equivalente a un filtrado pasa baja')
    subplot(2,3,1)
    imagesc(f);
    axis equal tight

    % TF y dibujo
    F = fft2shift(f);
    subplot(2,3,4)
    colormap(gray);
    imagesc(log(100+ abs(F)) );
    title('log abs TF')
    axis equal tight

    r = zeros(s);
    size(r);
    r2 = int32(s/2);

    % Función cuadrado de lado
    d = d*2;
    r(r2(1)-d:r2(1)+d, r2(2)-d:r2(2)+d) = 1;
    subplot(2,3,2)
    imagesc(r);
    titulo = sprintf('cuadrado de lado %d', 2*d+1);
    title(titulo)
    axis equal tight

    % TF y dibujo
    R = fft2shift(r);
    subplot(2,3,5)
    colormap(gray);
    imagesc(log(100+ abs(R)) );
    title('log abs TF')
    axis equal tight

    c = Convolucion(f, r, 'r');
    subplot(2,3,3)
    colormap(gray);
    imagesc(c );
    title('Convolución con cuadrado')
    axis equal tight

    % TF y dibujo
    C = fft2shift(c);
    subplot(2,3,6)
    colormap(gray);
    imagesc(log(100+ abs(C)) );
    title('log abs TF convolucion con cuadrado')
    axis equal tight
end

d = 1;
% Convoluciones con gaussianas
for k=1:3
    %Show Image
    n = n+1;
    H=figure(n);
    set(H,'Name','Filtrado por convolución con una gaussiana: equivalente a un filtrado pasa baja')
    subplot(2,3,1)
    imagesc(f);
    axis equal tight

    % TF y dibujo
    F = fft2shift(f);
    subplot(2,3,4)
    colormap(gray);
    imagesc(log(100+ abs(F)) );
    title('log abs TF')
    axis equal tight


    % Función gaussiana de lado
    d = d*2;
    r = Gausiana(s(2), s(1), d);
    subplot(2,3,2)
    imagesc(r);
    titulo = sprintf('Gaussiana de ancho %d', 2*d+1);
    title(titulo)
    axis equal tight

    % TF y dibujo
    R = fft2shift(r);
    subplot(2,3,5)
    colormap(gray);
    imagesc(log(100+ abs(R)) );
    title('log abs TF')
    axis equal tight

    c = Convolucion(f, r, 'r');
    subplot(2,3,3)
    colormap(gray);
    imagesc(c );
    title('Convolución con gaussiana')
    axis equal tight

    % TF y dibujo
    C = fft2shift(c);
    subplot(2,3,6)
    colormap(gray);
    imagesc(log(100+ abs(C)) );
    title('log abs TF convolucion con gaussiana')
    axis equal tight
end
