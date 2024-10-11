%aproksymacja metodą czebyszewa
syms x real;
fun = @(x) 1./(1 + x.^2);

f1 = @() Czebyszew(fun, 5); %(funkcja,ilosc wielomianow[wiecej = dokladniej])
timeit(f1)
%f1();

figure;
%aproksymacja metoda padego
f2 = @() fplot(pade(1./(1 + x.^2)));
timeit(f2)