function H = Hermite0_3(X, n)

H = X*0;

if n>3
    return;
end
switch n
    case 0
        H = H + 1;
    case 1
        H = 2*X;
    case 2
        H = 4*X.^2 - 2;
    case 3
        H = 8*X.^3 - 12*X;
end