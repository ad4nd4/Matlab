% Zakres częstotliwości z
z = linspace(-1, 1, 1000);

% Implementacja funkcji transformacji biliniowej H_d(z)
H_d = @(f) (1 + s.^(-1)) ./ (1 - s.^(-1));

% Implementacja przybliżonej funkcji H_a(z)
H_a = @(s) (1 - 0.5*s.^(-1)) ./ (1 + 0.5*s.^(-1));

% Obliczenia wartości funkcji dla danego zakresu z
H_d_values = H_d(s);
H_a_values = H_a(s);

% Rysowanie wykresu
figure;
plot(z, abs(H_d_values), 'b', 'LineWidth', 2, 'DisplayName', 'H_d(z)');
hold on;
plot(z, abs(H_a_values), 'r--', 'LineWidth', 2, 'DisplayName', 'H_a(z) (Przybliżenie)');
legend;
title('Porównanie funkcji transformacji biliniowej');
xlabel('z');
ylabel('|H(z)|');
grid on;
