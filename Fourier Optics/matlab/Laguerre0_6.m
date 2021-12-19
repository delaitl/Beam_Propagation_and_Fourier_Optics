function H = Laguerre0_6(X,n)

H = X*0;

if n>6
    return;
end
switch n
    case 0
        H = H + 1;
    case 1
        H = -X + 1;
    case 2
        H = 0.5*((X-4).*X + 2);
    case 3
        H = (((-X + 9).*X - 18).*X + 6)/6.0;
    case 4
        H = ((((X - 16).*X + 72).*X - 96).*X + 24)/24.0;
    case 5
        H = (((((-X + 25).*X - 200).*X + 600).*X - 600).*X + 120)/120.0;
    case 6
        H = ((((((X - 36).*X + 450).*X - 2400).*X + 5400).*X - 4320).*X + 720)/720;
end