%plot of the intensity for beta between 0 and 2 pi
Intensity = zeros(101);
beta=0:2*pi/100:2*pi;
for  i =1:101
    Intensity(i)= INTENSITY(beta(i));
end

figure
plot(beta,Intensity,'m')

title('Plot 2')
xlabel('beta [rad]')
ylabel('Intensity at the output [W/m^2]')
xlim([0 2*pi])