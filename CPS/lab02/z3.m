clear all; close all;

N = 100;
fs = 1000;

f1 = 50;
f2 = 100;
f3 = 150;
A1 = 50;
A2 = 100;
A3 = 150; 

t = (0:N-1)/fs;

x = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);
%DCT (A) i IDCT (S)
A = zeros(N);
S = zeros(N);
for k = 0:N-1
    for n = 0:N-1
        if k == 0
            A(k+1,n+1) = sqrt(1/N); %k=0 cos=1
        else
            A(k+1,n+1) = sqrt(2/N) * cos(pi*k*(2*n+1)/(2*N));
            S(k+1,n+1) = A(k+1,n+1); % Macierz S to transpozycja macierzy A w przypadku DCT-II
        end
    end
end
%A = dct(eye(N));
%S = idct(eye(N));
figure;
for k = 1:N
    plot(A(k,:), 'b'); hold on;
    plot(S(:,k), 'r--'); hold off;
    legend('Wiersz A', 'Kolumna S');
    title(['Wiersz/kolumna numer ', num2str(k)]);
    pause(0.5);
end

%analiza
y = A*x',
%rekonstrukcja
xr = S*y;

%weryfikacja
if norm(xr' - x) < 1e-10
    disp('Perfekcyjna rekonstrukcja jest możliwa.');
else
    disp('Perfekcyjna rekonstrukcja jest niemożliwa.');
end