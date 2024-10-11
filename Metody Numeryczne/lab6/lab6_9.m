close all; clear all;

fp = 1000;
Tp = 1 / fp;

definitional_transform = @(s) exp(s * Tp);
approx_transform = @(s) (1 + s / (2 * fp)) ./ (1 - s / (2 * fp));

s_values = linspace(-5, 5, 100);
figure;
plot(s_values, definitional_transform(s_values), '-b', 'LineWidth', 2, 'DisplayName', 'Definitional');
hold on;
plot(s_values, approx_transform(s_values), '--r', 'LineWidth', 2, 'DisplayName', 'Approximated');
xlabel('s');
ylabel('z');
legend('Location', 'Best');
grid on;
