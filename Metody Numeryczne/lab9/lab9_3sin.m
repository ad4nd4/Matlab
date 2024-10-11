f = @(x) sin(x);

accuracy = 0.001 / 100;  % 0.001%

a_1 = 3; %pi - pi/5;
b_1 = 4; %pi + pi/5;

max_iterations_sin = 100;

result_rf_sin = regulaFalsi(f, a_1, b_1, max_iterations_sin, accuracy);

fprintf('Miejsce zerowe funkcji sin(x) (regula-falsi): x = %.5f\n', result_rf_sin(end));
fprintf('Liczba iteracji: %d\n', length(result_rf_sin));

x_values_sin = 0 : 0.01 : 4*pi;
figure;
plot(x_values_sin, f(x_values_sin), 'b-');
hold on;
plot(result_rf_sin(end), 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');  % Miejsce zerowe
grid;
xlabel('x');
title('f(x) - Sinus');
legend('Funkcja', 'Miejsce zerowe');

function C = regulaFalsi(f, a, b, max_iterations, accuracy)
    C = zeros(1, max_iterations);
    for i = 1 : max_iterations
        fa = f(a);
        fb = f(b);
        c = b - (fb * (b - a)) / (fb - fa);
        C(i) = c;
        fc = f(c);
        if abs(fc) < accuracy
            break;
        end
        if fa * fc < 0
            b = c;
        else
            a = c;
        end
    end
    C = C(1:i);
end
