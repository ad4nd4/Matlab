close all; clear all;

syms x;
a = 0;
b = pi;

sub_cos = @(x) cos((a+b)/2 + (b-a)/2 * x);

% 2-pkt
nodes_2p = [-sqrt(1/3), sqrt(1/3)];
wages_2p = [1, 1];

field_cos_2p = 0;

for k = 1:length(nodes_2p)
    field_cos_2p = field_cos_2p + wages_2p(k) * sub_cos(nodes_2p(k));
end
field_cos_2p = field_cos_2p * (b-a)/2;

% 3-pkt kwadratura
nodes_3p = [-sqrt(3/5), 0, sqrt(3/5)];
wages_3p = [5/9, 8/9, 5/9];

field_cos_3p = 0;

for k = 1:length(nodes_3p)
    field_cos_3p = field_cos_3p + wages_3p(k) * sub_cos(nodes_3p(k));
end
field_cos_3p = field_cos_3p * (b-a)/2;

% wartosc obliczona
exact_integral_cos = integral(@cos, a, b);

error_cos_2p = abs(exact_integral_cos - field_cos_2p);
error_cos_3p = abs(exact_integral_cos - field_cos_3p);

disp('2-punktowa kwadratura');
disp(['Całka oznaczona funkcji cos [0, pi] = ', num2str(field_cos_2p), ', Błąd: ', num2str(error_cos_2p)]);
disp('3-punktowa kwadratura');
disp(['Całka oznaczona funkcji cos [0, pi] = ', num2str(field_cos_3p), ', Błąd: ', num2str(error_cos_3p)]);

