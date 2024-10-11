function C = CountP(x)
    n = 3;
    syms x;

    h = @(x) (x.^2 - 1)^n;
    third_derivative = diff(h, x, 3);

    P3 = (1/((2^3)*factorial(3))) * third_derivative;
    P3_simplified = simplify(P3);

    disp(['P3 przed uproszczeniem: ', char(P3)]);
    disp(['P3 po uproszczeniu: ', char(P3_simplified)]);
end