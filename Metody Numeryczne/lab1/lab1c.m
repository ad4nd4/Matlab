
x = -5 : 0.1 : 5;
f1 = x.^3 + x.^2 + x + 1;
f2 = x.^2 +1;

plot(x, f1)
grid
hold on

plot(x,  f2)
