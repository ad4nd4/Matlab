% optim_skocznia.m - przyklad profilu skoczni narciarskiej
x = 0 : 0.001 : 1;
figure;
for a = 1 : 0.5 : 5
    f = a*x.^2-(a+1)*x+1;
    plot(x,f); hold on;
end
grid; title('a=0:0.5:5'); xlabel('x'); ylabel('f(x)');
%unikanie mianownika=0
theta= 1e-6;
t = @(a) integral(@(x) sqrt(1+(2*a*x-a-1).^2)./(2*9.81*(1-(a*x.^2-(a+1)*x+1)+theta)),0,1);

a1 = 0.5;
a2 = 5;
eps = 0.01;

%metd złotego podziału
k = (sqrt(5)-1)/2;
b1 = a2 - k*(a2-a1);
b2 = a1 + k*(a2-a1);
iter = 0;

while abs(a2-a1) > eps
    if t(b1) < t(b2)
        %minimum jest w [a1,b2], wiec odrzucamy [b1,a2]
        a2 = b2;
        b2 = b1;
        %nowy punkt podzialu b1
        b1 = a2 - k*(a2-a1);
    else
        %odwrotnie
        a1 = b1;
        b1 = b2;
        b2 = a1 + k*(a2-a1);
    end
    iter = iter + 1;
end

fprintf('Optymalna wartosc a = %f\n', (a1+a2)/2);
fprintf('Minimalny czas przejazdu t(a) = %f\n', t((a1+a2)/2));
fprintf('Liczba iteracji = %d\n', iter);