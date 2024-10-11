clear all; close all;
%dane

f = @(x) sin(x);

accuracy = 0.001 / 100;  % 0.001%

a_1 = 3;
b_1 = 4;

max_iterations = 100;

% Używane metody
methods = {'bisection', 'regula-falsi', 'secant', 'newton-raphson'};

figure;
for i = 1:length(methods)
    method = methods{i};
    
    result = findx0(f, a_1, b_1, max_iterations, accuracy, method);
    fprintf('M.z. funkcji kwadratowej (%s): x = %.5f\n', method, result(end));
    fprintf('Liczba iteracji: %d\n', length(result));
    
    subplot(length(methods), 1, i);
    plot(-4:0.01:4, f(-4:0.01:4), 'b-', 'DisplayName', 'Funkcja');
    hold on;
    plot(result(end), 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'DisplayName', 'Miejsce zerowe');
    grid on;
    xlabel('x');
    title(['f(x) - ' method]);
    legend('Location', 'Best');
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

function C = bisection(f, a, b, max_iterations, accuracy)
    C = zeros(1, max_iterations);
    for k = 1 : max_iterations
        fa = f(a);
        fb = f(b);
        c = (a + b) / 2;
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
