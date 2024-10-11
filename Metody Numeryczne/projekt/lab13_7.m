N = 100000;
comparePiApproximationsWithGenerators(N);

function comparePiApproximationsWithGenerators(N)
    pi_exact = pi,

    % Monte Carlo z generatora multiplikatywnego
    [pi_mc_multi, time_mc_multi] = measureTime(@() monteCarloMethodWithGenerators(N, @multiplikatywnyGenerator));

    %Monte Carlo z generatora kongruencyjnego
    [pi_mc_kong, time_mc_kong] = measureTime(@() monteCarloMethodWithGenerators(N, @kongruencyjnyGenerator));

    %Monte Carlo z funkcji rand
    [pi_mc_rand, time_mc_rand] = measureTime(@() monteCarloMethodWithGenerators(N, @randGenerator));

    displayResult('Monte Carlo (Multiplikatywny)', pi_mc_multi, time_mc_multi);
    displayResult('Monte Carlo (Kongruencyjny)', pi_mc_kong, time_mc_kong);
    displayResult('Monte Carlo (rand)', pi_mc_rand, time_mc_rand);

    %czas
    function [result, executionTime] = measureTime(method)
        tic;
        result = method();
        executionTime = toc;
    end

    % wyniki, blad
    function displayResult(methodName, approximation, elapsedTime)
        errorRelative = abs(approximation - pi_exact) / pi_exact;
        disp([methodName ': ' num2str(approximation) ', Błąd względny: ' num2str(errorRelative) ', Czas: ' num2str(elapsedTime) ' sekundy']);
    end
end
function pi_approx = monteCarloMethodWithGenerators(n, generator)
    Nk = 0; % liczba trafień w koło

    for i = 1:n
        x = generator() * 2.0 - 1.0; % kwadrat o boku 2
        y = generator() * 2.0 - 1.0; % kwadrat o boku 2

        if (sqrt(x*x + y*y) <= 1.0) % koło o promieniu 1
            Nk = Nk + 1; % zwiększ liczbę trafień o 1
        end
    end

    pi_approx = 4.0 * Nk / n; % obliczone pi
end

function r = multiplikatywnyGenerator()
    persistent seed;
    if isempty(seed)
        seed = rand();
    end
    seed = mod(48271 * seed, 2^31 - 1);
    r = seed / (2^31 - 1);
end

function r = kongruencyjnyGenerator()
    persistent seed;
    if isempty(seed)
        seed = rand();
    end
    a = 1664525;
    c = 1013904223;
    seed = mod(a * seed + c, 2^31 - 1);
    r = seed / (2^31 - 1);
end

function r = randGenerator()
    r = rand();
end
