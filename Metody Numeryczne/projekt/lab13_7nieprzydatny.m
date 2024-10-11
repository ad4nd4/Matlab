function comparePiApproximations()
    pi_exact = pi;

    %Monte Carlo
    [pi_mc, time_mc] = measureTime(@() monteCarloMethod(1000000));

    %Szereg Leibniza
    [pi_leibniz, time_leibniz] = measureTime(@() leibnizSeries(1000));

    % Metoda Machina
    [pi_machin, time_machin] = measureTime(@() machinMethod(1000));

    %Gauss-Legendre
    [pi_gauss_legendre, time_gauss_legendre] = measureTime(@() gaussLegendreMethod(10));

    disp('pi = '), disp(pi),
    displayResult('Monte Carlo', pi_mc, time_mc);
    displayResult('Szereg Leibniza', pi_leibniz, time_leibniz);
    displayResult('Machin', pi_machin, time_machin);
    displayResult('Gauss-Legendre', pi_gauss_legendre, time_gauss_legendre);

    %time
    function [result, executionTime] = measureTime(method)
        tic;
        result = method();
        executionTime = toc;
    end
    function displayResult(methodName, approximation, elapsedTime)
        errorRelative = abs(approximation - pi_exact) / pi_exact;
        disp([methodName ': ' num2str(approximation) ', Błąd względny: ' num2str(errorRelative) ', Czas: ' num2str(elapsedTime) ' sekundy']);
    end
end


function pi_approx = monteCarloMethod(n)
    Nk = 0; % liczba trafień w koło

    for i = 1 : n
        x = rand(1, 1) * 2.0 - 1.0; % kwadrat o boku 2
        y = rand(1, 1) * 2.0 - 1.0; % kwadrat o boku 2

        if (sqrt(x*x + y*y) <= 1.0) % koło o promieniu 1
            Nk = Nk + 1; % zwiększ liczbę trafień o 1
        end
    end

    pi_approx = 4.0 * Nk / n; % obliczone pi
end
function pi_approx = leibnizSeries(n)
    pi_approx = 0;
    for k = 0:n
        pi_approx = pi_approx + (-1)^k / (2*k + 1);
    end
    pi_approx = 4 * pi_approx;
end

function pi_approx = machinMethod(n)
    pi_approx = 0;
    
    for k = 0:n
        pi_approx = pi_approx + ((-1)^k) * 4/(2*k + 1);
    end
end

function pi_approx = gaussLegendreMethod(n)
    a = 1;
    b = 1/sqrt(2);
    t = 1/4;
    p = 1;
    
    for i = 1:n
        a_next = (a + b)/2;
        b = sqrt(a * b);
        t = t - p * (a - a_next)^2;
        a = a_next;
        p = 2 * p;
    end
    
    pi_approx = (a + b)^2 / (4 * t);
end
