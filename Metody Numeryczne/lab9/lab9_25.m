clear all; close all;

it = 12;
a = 1/2; c = -0.1;

alpha = pi/4; % przykladowe alfa
b = tan(alpha);

f = @(x) a*x.^2 + b*x + c; 
fp = @(x) 2*a*x + b; 

x = -4 : 0.01 : 4;
plot(x, f(x), 'b-', x, fp(x), 'r-'); 
grid; xlabel('x'); title('f(x), fp(x)');
legend('Funkcja','Jej pochodna', 'Location', 'Best'); 


cb = nonlinsolvers(f, fp, -4, 10, 'bisection', it);
cr = nonlinsolvers(f, fp, -4, 10, 'regula-falsi', it);
cn = nonlinsolvers(f, fp, -4, 10, 'newton-raphson', it);

alpha_iter = zeros(1, it);
alpha_iter(1) = alpha;

for i = 2:it
    alpha_iter(i) = atan(cb(i-1));
end

figure;
plot(1:it, rad2deg(alpha_iter), 'o-');
xlabel('iter'); title('Zależność \alpha od liczby iteracji');
ylabel('\alpha (stopnie)');
grid on;

function C = nonlinsolvers(f, fp, a, b, solver, iter)
    C = zeros(1, iter);
    c = a; %pierwsze oszacowanie
    
    for i = 1 : iter
        fa = feval(f, a); fb = feval(f, b); fc = feval(f, c); fpc = feval(fp, c); % Obliczenia
        
        switch(solver)
            case 'bisection'
                if(fa * fc < 0) 
                    b = c;
                else
                    a = c;
                end
                c = (a + b) / 2;
                
            case 'regula-falsi'
                if(fa * fc < 0)
                    b = c;
                else
                    a = c;
                end
                c = b - fb * (b - a) / (fb - fa);
                
            case 'newton-raphson'
                c = c - fc / fpc;
                
            otherwise
                error('Nieznana metoda');
        end
        
        C(i) = c; % Zapamiętaj
    end
end
