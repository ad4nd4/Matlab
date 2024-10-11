%clear all; close all;

a = 2;
b = -150;
c = 126;

Wx1 = (-b-sqrt(b^2 - 4*a*c)) / (2*a);
Wx2 = (-b+sqrt(b^2 - 4*a*c)) / (2*a);

if abs(Wx1) > abs(Wx2)
    x1 = Wx1;
    x2 = 2*c / (-b-sqrt(b^2 - 4*a*c));
else
    x1 = Wx2;
    x2 = 2*c / (-b+sqrt(b^2 - 4*a*c));
end

disp("x1 = "), disp(x1);
disp("x2 = "), disp(x2);