clear all; close all;

%dane
alpha = 80;
a = 1;
b = tan(alpha);
c = -5;

f = @(x) a*x.^2 + b*x + c;
fp = @(x) 2*a*x + b;

accuracy = 0.001 / 100;  % 0.001%

a_1 = -4;
b_1 = 4;

max_iterations = 100;

methods = {'bisection', 'regula-falsi', 'newton-raphson'};

figure;
for i = 1:length(methods)
    method = methods{i};
    
    result = findx0(f, fp, a_1, b_1, max_iterations, accuracy, method);
    fprintf('M.z. funkcji kwadratowej (%s): x = %.5f\n', method, result(end));
    fprintf('Liczba iteracji: %d\n', length(result));
    
    subplot(length(methods), 1, i);
    plot(-4:0.01:4, f(-4:0.01:4), 'b-', 'DisplayName', 'Funkcja');
    hold on;
    plot(result(end), 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'DisplayName', 'Miejsce zerowe');
    grid on;
    xlabel('x');
    title(['f(x) and its derivative - ' method]);
    legend('show');
    
    % Zależność iteracji od alfa
    alpha_iter = zeros(1, length(result));
    alpha_iter(1) = alpha;
    for j = 2:length(result)
        alpha_iter(j) = atan(result(j-1));
    end
    
    figure;
    plot(1:length(result), rad2deg(alpha_iter), 'o-');
    xlabel('iter');
    ylabel('\alpha (stopnie)');
    title(['Zależność \alpha od liczby iteracji - ' method]);
    grid on;
end

function C = findx0(f, fp, a, b, max_iterations, accuracy, method)
    % Krótkie oznaczenia metod
    switch method
        case 'bisection'
            solver = 'bisection';
        case 'regula-falsi'
            solver = 'regula-falsi';
        case 'newton-raphson'
            solver = 'newton-raphson';
        otherwise
            error('Nieznana metoda');
    end
    C = nonlinsolvers(f, fp, a, b, solver, max_iterations);
end

function C = nonlinsolvers(f, fp, a, b, solver, iter)
    C = zeros(1, iter);
    c = a; %pierwsze oszacowanie
    
    for i = 1 : iter
        fa = feval(f, a); fb = feval(f, b); fc = feval(f, c); fpc = feval(fp, c); % Obliczenia
        
        switch(solver)
            case 'bisection'
                if(fa * fc < 0) 
                    b = c;
                else
                    a = c;
                end
                c = (a + b) / 2;
                
            case 'regula-falsi'
                if(fa * fc < 0)
                    b = c;
                else
                    a = c;
                end
                c = b - fb * (b - a) / (fb - fa);
                
            case 'newton-raphson'
                c = c - fc / fpc;
                
            otherwise
                error('Nieznana metoda');
        end
        
        C(i) = c; % Zapamiętaj
    end
end

