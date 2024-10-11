close all;
clear all;

erf_approx = @(x) 2/sqrt(pi) * exp(-x.^2);
x = linspace(0, 10, 200);

approx_integral = -erf_approx(x);
true_erf_values = erf(x);

figure;
plot(x, approx_integral, 'r--', 'LineWidth', 2, 'DisplayName', 'Przybliżona wartość całki');
hold on;
plot(x, true_erf_values, 'b', 'LineWidth', 2, 'DisplayName', 'Rzeczywista wartość erf(x)');
legend;
title('Przybliżenie funkcji erf(x) przez wartość całki');
xlabel('x');
ylabel('Wartość');
grid on;

