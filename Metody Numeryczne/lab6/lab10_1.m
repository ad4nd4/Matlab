% Funkcja do aproksymacji
f = @(x) 1./(1 + x.^2);

% Stopień licznika i mianownika
M = 1; % Stopień licznika
N = 1; % Stopień mianownika

% Generowanie punktów do rysowania funkcji
x_vals = linspace(-5, 5, 100);
y_vals_exact = f(x_vals);

% Użycie funkcji pade do znalezienia ułamka Padégo
[R_num, R_den] = pade(flipud(taylor(f, 'Order', M+N)), M, N);

% Tworzenie ułamka Padégo jako funkcji
R = @(x) polyval(R_num, x) ./ polyval(R_den, x);

% Obliczanie wartości aproksymowanej funkcji
y_vals_aprox = R(x_vals);

% Rysowanie wykresu
figure;
plot(x_vals, y_vals_exact, 'b', 'LineWidth', 2, 'DisplayName', 'Dokładna funkcja');
hold on;
plot(x_vals, y_vals_aprox, 'r--', 'LineWidth', 2, 'DisplayName', 'Aproksymacja Padégo');
legend;
title('Aproksymacja funkcji 1/(1+x^2) przy użyciu ułamka Padégo');
xlabel('x');
ylabel('y');
grid on;
