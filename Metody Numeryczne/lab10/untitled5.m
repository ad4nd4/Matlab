h = 100; m = 80; b = 15; v0 = 55; g = 9.81; alpha = pi/4; t0 = 0;
y = @(x) h + (tan(alpha) + m * g / (b * v0 * cos(alpha))) * x + (g * m^2) * log(1 - x * b / (m * v0 * cos(alpha))) / (b^2);

% Fibonacci search
a = 0; % początek przedziału
b = fzero(@(x) y(x)-h, 100); % koniec przedziału
tol = 10^(-5);
F = [ 0, 1 ]; n=2;
while( F(n) <= (b-a)/tol )
    n = n+1;
    F(n) = F(n-1)+F(n-2);
end
(b-a)/tol, F(n),
imax = n, pause
k = (1-F(imax-2)/F(imax)); % pause
yL = b - k*(b-a);
yR = a + k*(b-a);
i = imax-1;
while( i > 3 )
    k = (1-F(i-2)/F(i));
    if( y(yL)>y(yR) ) % szukamy maksimum, więc zmieniamy znak nierówności
        b = yR; yR = yL; yL = b-k*(b-a);
    else
        a = yL; yL = yR; yR = a+k*(b-a);
    end
    i = i - 1;
end
disp('FIBONACCI'); t0, iter, yopt = (a+b)/2, ymax = y(yopt)