close all;
clear all;

syms x;
a = 0;
b = pi;

sub_sin = @(x) sin((a+b)/2 + (b-a)/2 * x);

% 2-pkt Gaussa-Lagrangea
nodes_2p = [-sqrt(1/3), sqrt(1/3)];
wages_2p = [1, 1];

field_sin_2p = 0;

for k = 1:length(nodes_2p)
    field_sin_2p = field_sin_2p + wages_2p(k) * sub_sin(nodes_2p(k));
end
field_sin_2p = field_sin_2p * (b-a)/2;

% 3-pkt
nodes_3p = [-sqrt(3/5), 0, sqrt(3/5)];
wages_3p = [5/9, 8/9, 5/9];

field_sin_3p = 0;

for k = 1:length(nodes_3p)
    field_sin_3p = field_sin_3p + wages_3p(k) * sub_sin(nodes_3p(k));
end
field_sin_3p = field_sin_3p * (b-a)/2;

% obliczona
exact_integral_sin = integral(@sin, a, b);

% err
error_sin_2p = abs(exact_integral_sin - field_sin_2p);
error_sin_3p = abs(exact_integral_sin - field_sin_3p);

disp('2-punktowa kwadratura');
disp(['Całka oznaczona funkcji sin [0, pi] = ', num2str(field_sin_2p), ', Błąd: ', num2str(error_sin_2p)]);
disp('3-punktowa kwadratura');
disp(['Całka oznaczona funkcji sin [0, pi] = ', num2str(field_sin_3p), ', Błąd: ', num2str(error_sin_3p)]);

