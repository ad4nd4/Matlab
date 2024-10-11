% Definicja funkcji błędu
erf_exact = @(x) (2/sqrt(pi)) * integral(@(t) exp(-t.^2), 0, x);

% Przybliżenie Padé dla funkcji błędu z wykorzystaniem rozwinięcia w szereg Czebyszewa
n = 4;  % Stopień rozwinięcia w szereg Czebyszewa

% Obliczenie współczynników rozwinięcia w szereg Czebyszewa
cheb_coeffs = chebyshev_fit(erf_exact, n);

% Przybliżenie Padé z wykorzystaniem współczynników Czebyszewa
erf_pade_cheb = @(x) pade_approximation(x, cheb_coeffs);

% Wartości x dla których chcemy obliczyć przybliżenie
x_values = linspace(-5, 5, 100);

% Obliczenie wartości funkcji błędu oraz przybliżenia Padé z wykorzystaniem Czebyszewa
erf_exact_values = arrayfun(erf_exact, x_values);
erf_pade_cheb_values = arrayfun(erf_pade_cheb, x_values);

% Wykres porównawczy
figure;
plot(x_values, erf_exact_values, '-b', 'LineWidth', 2, 'DisplayName', 'Exact erf(x)');
hold on;
plot(x_values, erf_pade_cheb_values, '--r', 'LineWidth', 2, 'DisplayName', 'Padé Approximation erf(x) with Chebyshev');
xlabel('x');
ylabel('erf(x)');
legend('show');
title('Comparison of erf(x) and Padé Approximation with Chebyshev');
grid on;

% Funkcja przybliżająca Padé z wykorzystaniem współczynników Czebyszewa
function y = pade_approximation(x, coeffs)
    n = length(coeffs) - 1;
    numerator = 0;
    denominator = 0;

    for k = 0:n
        numerator = numerator + coeffs(k + 1) * x.^k;
        denominator = denominator + coeffs(k + 1) * chebyshevT(k, x);
    end

    y = numerator ./ denominator;
end

% Funkcja do uzyskania współczynników rozwinięcia w szereg Czebyszewa
function coeffs = chebyshev_fit(f, n)
    coeffs = zeros(1, n + 1);

    for k = 0:n
        integrand = @(x) f(x) .* chebyshevT(k, x);
        coeffs(k + 1) = 2/(pi) * integral(integrand, -1, 1);
    end
end
