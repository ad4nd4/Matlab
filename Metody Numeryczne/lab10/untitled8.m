z0 = 100; m = 80; c = 15; v0 = 55; g = 9.81;
f = @(t) -(z0 + m/c*(v0+(m*g)/c)*(1-exp(-(c/m)*t))-((m*g)/c)*t);

x1 = 1;
x2 = 4;
x3 = 7;
tol = 1e-6;
maxiter = 100;
ifigs = 1;
%x = linspace(x1, x3, 1000);

[t_optimal, height] = quadsearch(f, x1, x2, x3, tol, maxiter, ifigs, x);

disp(['t optymalny = ', num2str(t_optimal)]);
disp(['h max = ', num2str(-height)]);  % Uwaga: Wysokość jest ujemna w kontekście problemu bungee jumpingu
