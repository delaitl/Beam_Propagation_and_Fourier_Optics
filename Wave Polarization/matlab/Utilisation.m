

n = 0.45 + 5.47i
angle = 50
[Jxr,jyr] = Jones_reflection(1,1i,n,angle);
[psi,chi] = Ellipse(1,1i,n,angle);
alpha = Energy_reflected(1,1i,n,angle);