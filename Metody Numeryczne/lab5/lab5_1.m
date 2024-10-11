N = 20;
xmax = 40*pi/4;
xp = 0 : xmax/(N-1) : xmax;
xd = 0 : 0.001 : xmax;
yp = sin(xp);
yd = sin(xd);
figure
plot(xp, yp, 'ro', xd, yd, 'b-');
xlabel('x');
title('y(x)');
grid;

P = N-1;
a = polyfit(xp, yp, P),

xi = xd;
yi = polyval(a,xi);
a = a(end:-1:1),
yi_moje = zeros(1, length(xi));
for k = 1:N
    yi_moje = yi_moje + a(k)*xi.^(k-1);
end
max_abs_yi = max(abs(yi - yi_moje)),

figure;
plot( xp, yp, 'ro', xd, yd, 'b-', xi, yi, 'k-' ); 
xlabel('x'); 
title('y(x)'); 
grid;

figure;
plot( xd, yd-yi, 'k-' );
xlabel('x');
title('BLAD INTERPOLACJI NR 1');
grid;

yis = interp1( xp, yp, xi, 'spline' );
figure;
plot( xp, yp, 'ro', xd, yd, 'b-', xi, yi,'k-', xi, yis, 'k-');
xlabel('x'); 
title('y(x)'); 
grid; 

figure;
plot( xd, yd - yis, 'k-' ); 
xlabel('x'); 
title('BLAD INTERPOLACJI NR 2'); 
grid; 