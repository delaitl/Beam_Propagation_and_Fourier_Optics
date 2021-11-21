%In the left diopter referential
x1 = -60:0.1:0;
y1 = zeros(601);

for i =1:601
    %computation of the first image
    [y1(i),magn] = dist_magn(4,x1(i),1,1.33);
end

%In the right diopter referential
x2 = zeros(601);
y2 = zeros(601);
for i =1:601
    %change of reference
    x2(i) = y1(i)-8;

    %computation of the second image
    [y2(i),magn] = dist_magn(-4,x2(i),1.33,1);
end
figure
plot(x1,y2,'r')
ylim([-60 60])

title('Plot 2')
xlabel('Object position w.r.t. the left diopter [cm]')
ylabel('Image position w.r.t. the right diopter [cm]')

fprintf('y(-60) = %f \n',y2(1));
fprintf('y(-10) = %f \n',y2(501));
fprintf('y(-5) = %f \n',y2(551));
fprintf('y(0) = %f \n',y2(601));


%Image distance for infinite object
x1 = -1000000000;
[y1,magn] = dist_magn(4,x1,1,1.33);
[y_asympt,magn] = dist_magn(-4,y1-8,1.33,1);
fprintf('y_asympt = %f \n',y_asympt);

