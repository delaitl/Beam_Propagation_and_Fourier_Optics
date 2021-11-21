function []=PoincareSphere
% Draw a Poincare Sphere of radius 0.98
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/

[xs,ys,zs]=sphere(30);
axes('FontSize',14);
lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
surface(xs,ys,zs,'FaceColor', 'none','EdgeColor',lightGrey);


axis equal % so the sphere isn't distorted
view([1 1 0.75]) % adjust the viewing angle
grid on
hold on

xlabel('S1');
ylabel('S2');
zlabel('S3');
grid on;


x=[-1.2 1.2];   y=[0. 0.]; z=[0. 0.];
line(x,y,z,'LineWidth', 2);
text(1.4, 0, 0, '\bf S1','FontSize',14);

y=[-1.2 1.2]; x=[0. 0.]; z=[0. 0.];
line(x,y,z,'LineWidth', 2);
text(0, 1.2, 0, '\bf S2','FontSize',14);

z=[-1.2 1.2]; x=[0. 0.]; y=[0. 0.];
line(x,y,z,'LineWidth', 2);
text(0, 0, 1.2, '\bf S3','FontSize',14);
