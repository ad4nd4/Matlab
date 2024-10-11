syms x;
fun = @(x) cos(x);

field_corr = integral(fun, -pi/2, pi/2),

nodes = [-sqrt(3/5), 0, sqrt(3/5)];
wages = [5/9, 8/9, 5/9];         %wagi i węzły mają być zgodne z tymi wyprowadzonymi dla kwadratury Gaussa-Legendra

a = -pi/2;
b = pi/2;

N = 3;
field = 0;

for k=1:N
   field = field + wages(k)*fun( (a+b)/2 + ((b-a)/2)*nodes(k));
end

field = field * (b-a)/2,
err = abs(field - field_corr),