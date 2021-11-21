% Propagation Modes
% Script to show the permitted propagating modes in a uniaxial media
% The C axis is along the Z axis
% The k vector in in the XZ plane and its direction is given by the angle with X axis

clc

% Direction of the K vector
Theta = 90;
kx = 0.5*sind(Theta);
ky = 0;
kz = 0.5*cosd(Theta);
k = [kx ky kz];

% Refraction indexes
nx = 1;
ny = nx;
nz = 2;
n_in = [1/nx^2 0      0
        0      1/ny^2 0
        0      0      1/nz^2];
D0 = [0 0.6 0]; % Initial displacement vector

x = zeros(1,180);
y = x;
z = x;
% Rotation of the displacement vector in the plane
% perpendicular to K vector
for alfa=1:1:180
    R = rotationVectorToMatrix(2*k*deg2rad(-alfa));
    D = R * D0';
    x(alfa) = D(1);
    y(alfa) = D(2);
    z(alfa) = D(3);
end
h = figure(1);
% To generate a video
v = VideoWriter('prueba2.avi', 'Uncompressed AVI');
v.FrameRate = 10;
open(v);

for alfa=0:1:179
    R = rotationVectorToMatrix(2*k*deg2rad(-alfa));
    D = R * D0';
    
    plot3(x,y,z,'r', 'LineWidth', 1);
    
    hold on
    % k
    plot3([0 kx], [0 ky], [0 kz],'k', 'LineWidth', 3);
    plot3([kx kx], [0 0], [0 kz],'k', 'LineWidth', 1);
    axis([-1 1 -1 1 -1 1]*0.6);
    % Axis
    plot3([-1 1]*0.6, [0 0], [0 0],'k', 'LineWidth', 1);
    plot3([0 0], [-1 1]*0.6, [0 0],'k', 'LineWidth', 1);
    plot3([0 0], [0 0], [-1 1]*0.6,'k', 'LineWidth', 1);
    t = text(1.1*kx, 1.1*ky, 1.1*kz, 'k');
    t.Color = 'k';
    t.FontSize = 12;
    t.FontWeight = 'bold';
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    view(32, 24);
    grid on
    
    % D
    plot3([0 D(1)], [0 D(2)], [0 D(3)],'r', 'LineWidth', 3);
    t=text(1.1*D(1), 1.1*D(2), 1.1*D(3), 'D');
    t.Color = 'r';
    t.FontSize = 12;
    t.FontWeight = 'bold';
    plot3([D(1) D(1)], [D(2) D(2)], [0 D(3)],'r', 'LineWidth', 1);
    plot3([D(1) D(1)], [0 D(2)], [0 0],'r', 'LineWidth', 1);
    plot3([0 D(1)], [D(2) D(2)], [0 0],'r', 'LineWidth', 1);
    
    % Dp
    Dp = n_in * D;
    plot3([0 Dp(1)], [0 Dp(2)], [0 Dp(3)],'b', 'LineWidth', 2);
    t = text(1.1*Dp(1), 1.1*Dp(2), 1.1*Dp(3), 'Dp');
    t.Color = 'b';
    t.FontSize = 12;
    t.FontWeight = 'bold';
    plot3([Dp(1) Dp(1)], [Dp(2) Dp(2)], [0 Dp(3)],'b', 'LineWidth', 1);
    plot3([Dp(1) Dp(1)], [0 Dp(2)], [0 0],'b', 'LineWidth', 1);
    plot3([0 Dp(1)], [Dp(2) Dp(2)], [0 0],'b', 'LineWidth', 1);
    
    % kxDp
    kxDp = cross(k,Dp);
    plot3([0 kxDp(1)], [0 kxDp(2)], [0 kxDp(3)],'m', 'LineWidth', 2);
    t = text(1.1*kxDp(1), 1.1*kxDp(2), 1.1*kxDp(3), 'k x Dp');
    plot3([kxDp(1) kxDp(1)], [kxDp(2) kxDp(2)], [0 kxDp(3)],'m', 'LineWidth', 1);
    plot3([kxDp(1) kxDp(1)], [0 kxDp(2)], [0 0],'m', 'LineWidth', 1);
    plot3([0 kxDp(1)], [kxDp(2) kxDp(2)], [0 0],'m', 'LineWidth', 1);
    t.Color = 'm';
    t.FontSize = 12;
    t.FontWeight = 'bold';
    
    % -k x k x Dp
    kxkxDp = -3*cross(k,kxDp);
    plot3([0 kxkxDp(1)], [0 kxkxDp(2)], [0 kxkxDp(3)],'g', 'LineWidth', 3);
    t = text(1.1*kxkxDp(1), 1.1*kxkxDp(2), 1.1*kxkxDp(3), '-k x k x Dp');
    t.Color = 'g';
    t.FontSize = 12;
    t.FontWeight = 'bold';
    plot3([kxkxDp(1) kxkxDp(1)], [kxkxDp(2) kxkxDp(2)], [0 kxkxDp(3)],'g', 'LineWidth', 1);
    plot3([kxkxDp(1) kxkxDp(1)], [0 kxkxDp(2)], [0 0],'g', 'LineWidth', 1);
    plot3([0 kxkxDp(1)], [kxkxDp(2) kxkxDp(2)], [0 0],'g', 'LineWidth', 1);
    
    
    t = text(-0.2, -0.5, -0.45,sprintf('Theta=%dº', Theta));
    t.FontSize = 12;
    t.FontWeight = 'bold';
    
    title('Not Permited mode');
    hold off
    drawnow
    pause(0.01)

    if (alfa == 0)
        title('Ordinary Wave');
        t = text(-0.3, -0.3, -0.45,'Ordinary Wave');
        t.FontSize = 12;
        t.FontWeight = 'bold';
        for i=1:10
            fr = getframe;
            writeVideo(v,fr);
        end
        pause(2)
    elseif (alfa == 90)
        title('Extraordinary Wave');
        t = text(-0.3, -0.3, -0.45,'Extraordinary Wave');
        t.FontSize = 12;
        t.FontWeight = 'bold';
        for i=1:10
            fr = getframe;
            writeVideo(v,fr);
        end
        pause(2)
    else
        t = text(-0.3, -0.3, -0.45,'Not Permited mode');
        t.FontSize = 12;
        t.FontWeight = 'bold';
    end
    
    
        
    fr = getframe;
    writeVideo(v,fr);

end

close(v)