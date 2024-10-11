close all;
clear all;

syms x;
a = -pi/2;
b = pi/2;

% Do podstawienia
sub_cos = @(x) cos((a+b)/2 + (b-a)/2 * x);
sub_sin = @(x) sin((a+b)/2 + (b-a)/2 * x);

% 2-pkt Gaussa-Lagrangea
nodes_2p = [-sqrt(1/3), sqrt(1/3)];
wages_2p = [1, 1];

field_cos_2p = 0;
field_sin_2p = 0;

for k = 1:length(nodes_2p)
    field_cos_2p = field_cos_2p + wages_2p(k) * sub_cos(nodes_2p(k));
    field_sin_2p = field_sin_2p + wages_2p(k) * sub_sin(nodes_2p(k));
end
field_cos_2p = field_cos_2p * (b-a)/2;
field_sin_2p = field_sin_2p * (b-a)/2;

% 3-punktowa kwadratura Gaussa-Lagrange'a
nodes_3p = [-sqrt(3/5), 0, sqrt(3/5)];
wages_3p = [5/9, 8/9, 5/9];

field_cos_3p = 0;
field_sin_3p = 0;

for k = 1:length(nodes_3p)
    field_cos_3p = field_cos_3p + wages_3p(k) * sub_cos(nodes_3p(k));
    field_sin_3p = field_sin_3p + wages_3p(k) * sub_sin(nodes_3p(k));
end
field_cos_3p = field_cos_3p * (b-a)/2;
field_sin_3p = field_sin_3p * (b-a)/2;

% Analityczne wartości całek
exact_integral_cos = integral(@cos, a, b);
exact_integral_sin = integral(@sin, 0, pi);

% Błędy
error_cos_2p = abs(exact_integral_cos - field_cos_2p);
error_sin_2p = abs(exact_integral_sin - field_sin_2p);

error_cos_3p = abs(exact_integral_cos - field_cos_3p);
error_sin_3p = abs(exact_integral_sin - field_sin_3p);

disp(['Całka oznaczona funkcji cos [-pi/2, pi/2] = ', num2str(field_cos_2p), ', Błąd: ', num2str(error_cos_2p)]);
disp(['Całka oznaczona funkcji sin [0, pi] = ', num2str(field_sin_2p), ', Błąd: ', num2str(error_sin_2p)]);

disp(['Całka oznaczona funkcji cos [-pi/2, pi/2] (3-punktowa kwadratura) = ', num2str(field_cos_3p), ', Błąd: ', num2str(error_cos_3p)]);
disp(['Całka oznaczona funkcji sin [0, pi] (3-punktowa kwadratura) = ', num2str(field_sin_3p), ', Błąd: ', num2str(error_sin_3p)]);
