close all; clear all;

f = @(x) 2/sqrt(pi) * arrayfun(@(x) integral(@(t) exp(-t.^2), 0, x), x);

degree = 15;
czeb_nodes = cos((2*(1:degree+1)-1)*pi/(2*(degree+1)));
czeb_values = f(czeb_nodes);
x = linspace(0, 2, 200);

% wsp
czeb_co = polyfit(czeb_nodes, czeb_values, degree);
czeb_approx = polyval(czeb_co, x);

figure;
plot(x, f(x), 'b', 'LineWidth', 2, 'DisplayName', 'Rzeczywista funkcja');
hold on;
plot(czeb_nodes, czeb_values, 'ro', 'MarkerSize', 10, 'DisplayName', 'Węzły Czebyszewa');
plot(x, czeb_approx, 'r--', 'LineWidth', 2, 'DisplayName', 'Aproksymacja Czebyszewa');
legend('Location', 'Best');
title('Aproksymacja funkcji za pomocą wielomianu Czebyszewa');
xlabel('x');
ylabel('y');
grid on;
