syms x1 x2
f = 2 + x1 - x2 + 2*x1^2 + 2*x1*x2 + x2^2;
grad = [diff(f,x1), diff(f,x2)];
x0 = [0, 0];
alpha = 0.1;
tol = 1e-6;
max_iter = 1000;
iter = 0;

while iter < max_iter
    iter = iter + 1;
    x1_new = x0 - alpha*double(subs(grad, [x1, x2], x0));
    if norm(x1_new - x0) < tol
        break;
    end
    x0 = x1_new;
end

fprintf('Minimum: (%.4f, %.4f)\n', x0(1), x0(2));