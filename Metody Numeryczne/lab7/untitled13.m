n = 3;
syms x;

% Obliczenie trzeciej pochodnej wielomianu Hermite'a
hermite_polynomial = hermite(n, x);
third_derivative = diff(hermite_polynomial, x, 3);

% Obliczenie współczynnika P3
P3 = (2*n + 1)/(n + 1) * x * ((1/(2^n * factorial(n))) * third_derivative) - 2/(n + 1) * ((1/(2^(n-1) * factorial(n-1))) * diff(hermite(n, x, 1));

% Wyświetlenie wyników
disp(['Trzecia pochodna wielomianu Hermite\'a: char(third_derivative)]);
disp(['Współczynnik P3: ', char(P3)]);
