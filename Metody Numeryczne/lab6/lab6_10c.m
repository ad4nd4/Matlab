close all; clear all;

f = @(x) 1./(1 + x.^2);

degree = 5;

czeb_nodes = cos((2*(1:degree+1)-1)*pi/(2*(degree+1)));
czeb_values = f(czeb_nodes);

czeb_coeffs = polyfit(czeb_nodes, czeb_values, degree);

x = linspace(-3, 3, 200);
czeb_approx_values = polyval(czeb_coeffs, x);

% Rysowanie wykresu
figure;
plot(x, f(x), 'b', 'LineWidth', 2, 'DisplayName', 'Rzeczywista funkcja');
hold on;
plot(czeb_nodes, f(czeb_nodes), 'ro', 'MarkerSize', 10, 'DisplayName', 'Węzły Czebyszewa');
plot(x, czeb_approx_values, 'r--', 'LineWidth', 2, 'DisplayName', 'Aproksymacja Czebyszewa');
legend('Location', 'Best');
title('Aproksymacja funkcji 1/(1+x^2) za pomocą wielomianu Czebyszewa');
xlabel('x');
ylabel('y');
grid on;

ylim([0, 1.5]);

