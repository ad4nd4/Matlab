clear all;
close all;

%dane:
m = 5;
v0 = 50;
alpha = 30;
h = 50;
g = 9.81;
b = 0.3;

alpha = alpha / 180 * pi;

y = @(x) h + (tan(alpha) + m * g / (b * v0 * cos(alpha))) * x + (g * m^2) * log(1 - x * b / (m * v0 * cos(alpha))) / (b^2);
y2 = @(x) h + tan(alpha) * x - g / (2 * v0^2 * cos(alpha)) * x.^2;

x_zeros_y = fzero(y, [0, 350]);
x_zeros_y2 = fzero(y2, [0, 350]);

fprintf('M.z. y(x): x = %.2f\n', x_zeros_y);
fprintf('M.z. y2(x): x = %.2f\n', x_zeros_y2);

x = 0:1:350;

figure; 
plot(x, y(x)); 
xlabel('x'); 
ylabel('y'); 
title('y(x)'); 
grid;

figure; 
plot(x, y2(x)); 
xlabel('x'); 
ylabel('y'); 
title('y2(x)'); 
grid;
