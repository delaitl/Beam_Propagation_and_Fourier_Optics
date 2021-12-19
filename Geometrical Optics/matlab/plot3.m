%In the left diopter referential
x1 = -60:0.1:0;
magn1 = zeros(601);
y1 = zeros(601);

for i =1:601
    %computation of the first image and magnification
    [y1(i),magn1(i)] = dist_magn(4,x1(i),1,1.33);
end

%In the right diopter referential
x2 = zeros(601);
magn2 = zeros(601);

for i =1:601
    %change of reference
    x2(i) = y1(i)-8;

    %computation of the second Magnification
    [y2,magn2(i)] = dist_magn(-4,x2(i),1.33,1);
end
figure
plot(x1,magn2,'g')
ylim([-10 10])

title('Plot 3')
xlabel('Object position w.r.t. the left diopter [cm]')
ylabel('Total Magnification [\]')

%Calcul of values of interest
fprintf('magn2(-60) = %f \n',magn2(1));
fprintf('magn2(-15) = %f \n',magn2(451));
fprintf('magn2(-5) = %f \n',magn2(551));
fprintf('magn2(-2) = %f \n',magn2(581));
fprintf('magn2(0) = %f \n',magn2(601));
fprintf('magn2(-50) = %f \n',magn2(101));


%Calcul de l'asymptote H
x1 = -100000000000;
[y1,magn] = dist_magn(4,x1,1,1.33);
[y_asympt,magn] = dist_magn(-4,y1-8,1.33,1);
fprintf('magn_asympt = %f \n',magn);