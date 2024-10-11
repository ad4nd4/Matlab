clear all; close all;

T = 2*pi;

% sin 100 pkt z 4 na okres
x_original = (0 : T/4 : 25*T);
y_original = sin(x_original);

% Zakres dla interpolacji
x_interpolated = (0 : T/32 : 25*T);
y_interpolated = zeros(size(x_interpolated));

for i = 1:length(x_interpolated)
    y_interpolated(i) = sum(y_original .* sinc((pi/T) * (x_interpolated(i) - x_original)/(T/4)));
end

% Wykresy
figure;
plot(x_original, y_original, 'ro-', 'LineWidth', 2, 'DisplayName', 'Original Sinusoid');
hold on;
plot(x_interpolated, y_interpolated, 'b.-', 'LineWidth', 1, 'DisplayName', 'Interpolated Sinusoid');
xlabel('x');
title('Sinusoid Interpolation using sinc()');
legend('Location', 'Best');
grid on;