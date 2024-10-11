clear all; close all;
xi = [0, 1, 1.7, 2, 3];
yi = [0.1, 1, 0, 2.1, 1.8];

spline_interp = spline(xi, [0, yi, 0]);

x_values = linspace(min(xi), max(xi), 100);

% Wykresy
figure;
hold on;

plot(xi, yi, 'ro', 'MarkerSize', 5, 'LineWidth', 2);

y_values = ppval(spline_interp, x_values);
plot(x_values, y_values, 'b-', 'LineWidth', 2, 'DisplayName', 'Spline Interpolation');

hold off;

title('Interpolacja Spine');
xlabel('x');
ylabel('y');
legend('Location', 'Best');
grid on;
