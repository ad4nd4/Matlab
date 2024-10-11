
rosenbrock = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [-1.9, 2];

options = optimoptions('fminunc', 'Display', 'iter', 'Algorithm', 'quasi-newton');

[x_min, f_min, exitflag, output] = fminunc(rosenbrock, x0, options);

disp('Wyniki optymalizacji:');
disp(['Minimum funkcji: ', num2str(f_min)]);
disp(['Punkt minimum: ', num2str(x_min)]);
disp(['Liczba iteracji: ', num2str(output.iterations)]);
disp(['Liczba wywołań funkcji: ', num2str(output.funcCount)]);
