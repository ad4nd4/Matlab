syms x y
f = x * exp(-x^2 - y^2) + (x^2 + y^2)/20;
dfdx = diff(f, x);
dfdy = diff(f, y);
d2fdx2 = diff(dfdx, x);
d2fdxdy = diff(dfdx, y);
d2fdy2 = diff(dfdy, y);
x0 = [0; 0];
tol = 1e-6;
max_iter = 100;
iter = 0;

while iter < max_iter
    iter = iter + 1;
    J = double([subs(dfdx, [x, y], x0'), subs(dfdy, [x, y], x0');
                subs(d2fdx2, [x, y], x0'), subs(d2fdxdy, [x, y], x0');
                subs(d2fdxdy, [x, y], x0'), subs(d2fdy2, [x, y], x0')]);

    grad = double([subs(dfdx, [x, y], x0'); subs(dfdy, [x, y], x0')]);
    
    x1 = x0 - J(1:2, 1:2)\grad;
    if norm(x1 - x0) < tol
        break;
    end
    x0 = x1;
end

f_min = f(x0(1), x0(2));
f_max = f(x1(1), x1(2));

fprintf('Minimum: (%.4f, %.4f), Value: %.4f\n', x0(1), x0(2), f_min);
fprintf('Maximum: (%.4f, %.4f), Value: %.4f\n', x1(1), x1(2), f_max);
