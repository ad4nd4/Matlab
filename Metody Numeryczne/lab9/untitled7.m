clear all; close all;

% Dane
alpha_values = [5, 10, 45, 80];
accuracy = 0.001 / 100;  % 0.001%

a_1 = -4;
b_1 = 4;

max_iterations = 100;

methods = {'bisection', 'regula-falsi', 'secant', 'newton-raphson'};

results = struct('method', methods, 'alphas', [], 'iteration_counts', [], 'zero_positions', []);

figure;

for i = 1:length(methods)
    method = methods{i};
    
    alphas = [];
    iteration_counts = [];
    zero_positions = [];
    
    for j = 1:length(alpha_values)
        alpha = alpha_values(j);
        b = tan(alpha);

        f = @(x) x.^2 + b*x - 5;

        result = findx0(f, a_1, b_1, max_iterations, accuracy, method);
        iteration_counts = [iteration_counts, length(result)];
        zero_positions = [zero_positions, result(end)];
        alphas = [alphas, alpha];
    end
    
    
    results(i).alphas = alphas;
    results(i).iteration_counts = iteration_counts;
    results(i).zero_positions = zero_positions;

    subplot(2, length(methods), i);
    plot(-4:0.01:4, f(-4:0.01:4), 'b-', 'DisplayName', 'Funkcja');
    hold on;
    scatter(results(i).zero_positions, zeros(size(results(i).zero_positions)), 'go', 'filled', 'DisplayName', 'Miejsce zerowe');
    grid on;
    xlabel('x');
    title(['Funkcja z miejscami zerowymi - ' method]);
    legend('show');

    % Wykres zależności liczby iteracji od kąta alfa
    subplot(2, length(methods), length(methods) + i);
    plot(results(i).alphas, results(i).iteration_counts, 'o-', 'DisplayName', method);
    grid on;
    xlabel('Kąt alfa (stopnie)');
    ylabel('Liczba iteracji');
    title(['Liczba iteracji dla różnych wartości kąta alfa - ' method]);
    legend('show');
end

% znajdowanie miejsca zerowego
function C = findx0(f, a, b, max_iterations, accuracy, method)
    C = zeros(1, max_iterations);
    switch method
        case 'bisection'
            C = bisection(f, a, b, max_iterations, accuracy);
        case 'regula-falsi'
            C = regulaFalsi(f, a, b, max_iterations, accuracy);
        case 'secant'
            C = secant(f, a, b, max_iterations, accuracy);
        case 'newton-raphson'
            C = newtonRaphson(f, a, max_iterations, accuracy);
        otherwise
            error('Nieznana metoda');
    end
end

function C = regulaFalsi(f, a, b, max_iterations, accuracy)
    C = zeros(1, max_iterations);
    for k = 1 : max_iterations
        fa = f(a);
        fb = f(b);
        c = b - (fb * (b - a)) / (fb - fa);
        C(k) = c;
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
    C = C(1:k);
end

function C = secant(f, a, b, max_iterations, accuracy)
    C = zeros(1, max_iterations);
    for k = 1 : max_iterations
        fa = f(a);
        fb = f(b);
        c = b - fb * (b - a) / (fb - fa);
        C(k) = c;
        fc = f(c);
        if abs(fc) < accuracy
            break;
        end
        a = b;
        b = c;
    end
    C = C(1:k);
end

function C = newtonRaphson(f, a, max_iterations, accuracy)
    C = zeros(1, max_iterations);
    for k = 1 : max_iterations
        fa = f(a);
        fpa = derivative(f, a);
        if fpa == 0
            error('Pochodna równa zeru. Metoda Newtona-Raphsona nie może być zastosowana.');
        end
        c = a - fa / fpa;
        C(k) = c;
        fc = f(c);
        if abs(fc) < accuracy
            break;
        end
        a = c;
    end
    C = C(1:k);
end

% obl. pochodnej
function df = derivative(f, x)
    h = 1e-6;
    df = (f(x + h) - f(x - h)) / (2 * h);
end
