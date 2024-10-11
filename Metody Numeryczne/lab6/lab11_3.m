close all; clear all;

approx_erf = @(x, terms) (2/sqrt(pi)) * sum((-1).^((1:terms)-1) .* x.^(2*(1:terms)-1) ./ factorial(2*(1:terms)-1));

x = linspace(0, 2, 200);

terms = 5;

approx_vals = arrayfun(@(x) approx_erf(x, terms), x);  %apr
exact_vals = erf(x);                                   %real

figure;
plot(x, exact_vals, 'b', 'LineWidth', 2, 'DisplayName', 'Wbudowana funkcja erf(x)');
hold on;
plot(x, approx_vals, 'r--', 'LineWidth', 2, 'DisplayName', 'Przybliżenie szeregiem Taylora');
legend('Location', 'Best');
title('Aproksymacja funkcji za pomocą szeregu Taylora');
xlabel('x');
ylabel('y');
grid on;
