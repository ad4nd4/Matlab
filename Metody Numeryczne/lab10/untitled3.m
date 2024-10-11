
h = 100; m = 80; b = 15; v0 = 55; g = 9.81; alpha = pi/4;
y = @(x) h + (tan(alpha) + m * g / (b * v0 * cos(alpha))) * x + (g * m^2) * log(1 - x * b / (m * v0 * cos(alpha))) / (b^2);

a = 0; % początek przedziału
b = fzero(@(x) y(x)-h, 100); % koniec przedziału

% Golden search
k = 2/(1+sqrt(5)); % = (sqrt(5)-1)/2;
yL = b-k*(b-a);
yR = a+k*(b-a);
iter = 0;
while( (b-a)>1e-6 )
    if( y(yL)>y(yR) ) % szukamy maksimum, więc zmieniamy znak nierówności
        b = yR; yR = yL; yL = b-k*(b-a);
    else
        a = yL; yL = yR; yR = a+k*(b-a);
    end
    iter = iter + 1;
end
disp('GOLDEN'); iter, yopt = (a+b)/2, ymax = y(yopt)

