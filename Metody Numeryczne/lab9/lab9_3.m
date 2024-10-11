a = 1;
c = -0.1;

f = @(x) a*x.^2 + b*x + c;

clear all; close all;

% Parametry
accuracy = 0.001 / 100;  % 0.001%
a_1 = -4;
b_1 = 4;
max_iterations = 100;
angles = 1:1:90;

iteration_matrix = zeros(length(angles), max_iterations);

for i = 1:length(angles)
    alpha = angles(i);
    b = tan(alpha);
    f = @(x) x.^2 + b*x - 0.1;
    result_rf = regulaFalsi(f, a_1, b_1, max_iterations, accuracy);
    iteration_matrix(i, 1:length(result_rf)) = result_rf;
end

figure;
plot(angles, sum(iteration_matrix > 0, 2), '-o');
xlabel('Kąt nachylenia (\alpha)');
ylabel('Liczba iteracji');
title('Zależność liczby iteracji od kąta nachylenia');
grid on;


fprintf('Miejsce zerowe funkcji kwadratowej (regula-falsi): x = %.5f\n', result_rf(end));
fprintf('Liczba iteracji: %d\n', length(result_rf));

x_values = -4 : 0.01 : 4;
figure;
plot(x_values, f(x_values), 'b-');
hold on;
plot(result_rf(end), 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');  % Miejsce zerowe
grid;
xlabel('x');
title('f(x) and its derivative');
legend('Funkcja', 'Miejsce zerowe');



function C = regulaFalsi(f, a, b, max_iterations, accuracy)
    C = zeros(1, max_iterations); %wyniki
    for k = 1 : max_iterations
        fa = f(a);
        fb = f(b);
        c = b - (fb * (b - a)) / (fb - fa);  % wzor
        C(k) = c;  % zapamietaj
        fc = f(c);
        if abs(fc) < accuracy
            break;  %wyst dokl
        end
        if fa * fc < 0
            b = c;
        else
            a = c;
        end
    end
    C = C(1:k); %l. teracji
end
