close all;
clear all;

f = @(x) 1./(1 + x.^2);

M = 10; % Stopień licznika
N = 2 % Stopień mianownika

x_data = linspace(-1, 1, M+N+1);
y_data = f(x_data);

co = polyfit(x_data, y_data, M+N);

R_num = co(1:M+1);
R_den = [1, co(M+2:end)];
R = @(x) polyval(R_num, x) ./ polyval(R_den, x);

x_vals = linspace(-2, 2, 200);
y_vals_exact = f(x_vals);
y_vals_aprox = -R(x_vals);

% Rysowanie wykresu
figure;
plot(x_vals, y_vals_exact, 'b', 'LineWidth', 2, 'DisplayName', 'Dokładna funkcja');
hold on;
plot(x_vals, y_vals_aprox, 'r--', 'LineWidth', 2, 'DisplayName', 'Aproksymacja Padégo');
legend('Location', 'Best');
title('Aproksymacja funkcji 1/(1+x^2) przy użyciu ułamka Padégo');
xlabel('x');
ylabel('y');
grid on;
