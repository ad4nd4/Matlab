function lab6_115()
    clear all;
    close all;

    N = 10; % stopień wielomianu interpolującego
    a = -3; b = 3; % argument funkcji myfun() od-do
    xi = a : 0.01 : b; % dokładne, równomierne próbkowanie argumentu funkcji
    yref = myfun(xi); % wartości funkcji próbkowanej gęsto

    % Generowanie węzłów Czebyszewa
    xk = cheb_nodes(a, b, N);

    % Przeskalowanie węzłów do przedziału [a, b]
    xk = (b - a) / 2 * xk + (a + b) / 2;

    % Wartości funkcji w węzłach Czebyszewa
    yk = myfun(xk);

    % Interpolacja Newtona w węzłach Czebyszewa
    [yi, p, an] = funTZ_newton(xk, yk, xi);

    % Probkowanie rzadkie w węzłach równomiernych, potem interpolacja
    xkk = a : (b - a) / N : b; % próbkowanie równomierne
    ykk = myfun(xkk); % funkcja próbkowana w węzłach równomiernych
    [yii, p, ann] = funTZ_newton(xkk, ykk, xi);

    % Rysowanie wykresu
    figure; 
    plot(xi, yref, 'r-', xi, yi, 'b-', xk, yk, 'bo', xi, yii, 'b-.', xkk, ykk, 'bs');
    xlabel('x'); 
    title('y=f(x)'); 
    grid;
    legend('Rzeczywista funkcja', 'Interpolacja w węzłach Czebyszewa', 'Węzły Czebyszewa', 'Interpolacja w równomiernych węzłach', 'Węzły równomierne');
end

function nodes = cheb_nodes(a, b, N)
    k = 0:N;
    theta = ((2 * N + 1) - 2 * k) * pi / (2 * N + 2);
    nodes = cos(theta);
end

function [yi, p, a] = funTZ_newton(xk, yk, xi)
    Nk = length(xk);
    Ni = length(xi);

    % Tworzenie tabeli różnic dzielonych
    D = zeros(Nk, Nk);
    D(:, 1) = yk;

    for c = 2:Nk
        for r = c:Nk
            D(r, c) = (D(r, c-1) - D(r-1, c-1)) / (xk(r) - xk(r-c+1));
        end
    end

    % Ekstrakcja współczynników
    a = diag(D);

    % Interpolowane wartości
    yi = zeros(1, Ni);
    for i = 1:Ni
        factors = cumprod([1, xi(i) - xk(1:Nk-1)]);
        yi(i) = sum(factors .* a);
    end

    % Współczynniki wielomianu interpolacyjnego
    p = zeros(1, Nk);
    p(Nk) = a(1);

    for k = 1:Nk-1
        padded_poly = [zeros(1, Nk-k-1), poly(xk(1:k))];
        p = p + a(k+1) * padded_poly;
    end
end

function y = myfun(x)
    % Moja aproksymowana funkcja
    y = 1./(1 + x.^2);
end