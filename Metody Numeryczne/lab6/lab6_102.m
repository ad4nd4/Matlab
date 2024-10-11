close all; clear all;

x = linspace(-2, 2, 200);
y = 1./(1 + x.^2);

degree = 5;
coefficients = polyfit(x, y, degree);

poly_aprox = polyval(coefficients, x);


figure;
plot(x, y, 'b', 'LineWidth', 2, 'DisplayName', 'Dokładna funkcja');
hold on;
plot(x, poly_aprox, 'r--', 'LineWidth', 2, 'DisplayName', 'Aproksymacja średniokwadratowa');
legend('Location', 'Best');
title('Aproksymacja funkcji 1/(1+x^2) przez wielomian');
xlabel('x');
ylabel('y');
grid on;
