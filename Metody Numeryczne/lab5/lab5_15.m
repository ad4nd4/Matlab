clear all; close all;

xi = [0, 1, 1.7, 2, 3];
yi = [0.1, 1, 0, 2.1, 1.8];

n = length(xi) - 1; % Liczba przedziałów

% Współczynniki lokalne
ai = zeros(1, n);
bi = zeros(1, n);
ci = zeros(1, n);
di = zeros(1, n);

for i = 1:n
    hi = xi(i+1) - xi(i);
    
    % macierz ze wzoru
    A = [
        1, 0, 0, 0;
        1, hi, hi^2, hi^3;
        0, 1, 0, 0;
        0, 1, 2*hi, 3*hi^2];
    
    % co*B = A
    B = [yi(i); yi(i+1); 0; 0];
    %rozw ukl rownan
    coeffs = A \ B;
    
    ai(i) = coeffs(1);
    bi(i) = coeffs(2);
    ci(i) = coeffs(3);
    di(i) = coeffs(4);
end

disp('Współczynniki:');
disp('   ai         bi         ci         di');
disp([ai; bi; ci; di]);

%------------------------------------------------------ ploty

figure;
hold on;

plot(xi, yi, 'ro', 'MarkerSize', 5, 'LineWidth', 2);

% Wykresy int
for i = 1:n
    x_values = linspace(xi(i), xi(i+1), 100);
    y_values = ai(i) + bi(i) * (x_values - xi(i)) + ci(i) * (x_values - xi(i)).^2 + di(i) * (x_values - xi(i)).^3;
    plot(x_values, y_values, 'LineWidth', 2, 'DisplayName', ['Wielomian ', num2str(i)]);
end

hold off;

title('Interpolacja Kubiczna');
xlabel('x');
ylabel('y');
legend('Location', 'Best');
grid on;

