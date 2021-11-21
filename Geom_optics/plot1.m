x = -60:0.1:0;
y = zeros(601);
for i =1:601
    [y(i),magn] = dist_magn(4,x(i),1,1.33);
end
figure
plot(x,y,'m')
ylim([-60 60])

title('Plot 1')
xlabel('Object position w.r.t. the diopter [cm]')
ylabel('Image position w.r.t. the diopter [cm]')

fprintf('y(-60) = %f \n',y(1));
fprintf('y(-30) = %f \n',y(301));
fprintf('y(-15) = %f \n',y(451));
fprintf('y(-10) = %f \n',y(501));
fprintf('y(0) = %f \n',y(601));