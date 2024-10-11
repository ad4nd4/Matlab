clear all; close all; clc;

N = 100;
fs = 1000;
t = (0:N-1)/fs;
f1 = 50; 
f2 = 105;
f3 = 150;

A1 = 50;
A2 = 100; 
A3 = 150;

x = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);

%DCT i IDCT
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
figure;
for k = 1:N
    plot(A(k,:), 'b'); hold on;
    plot(S(:,k), 'r--'); hold off;
    legend('Wiersz A', 'Kolumna S');
    title(['Wiersz/kolumna numer ', num2str(k)]);
    pause(0.1);
end
%A = dct(eye(N));
%S = idct(eye(N));
%an
y = A*x',
%re
xr = S*y;

f = (0:N-1)*fs/N;

figure; stem(f, abs(y)); title('Analiza DCT po zmianie f2 na 105 Hz');
xlabel('Częstotliwość (Hz)'); ylabel('|DCT|');

disp('Czy rekonstrukcja jest perfekcyjna po zmianie f2 na 105 Hz?');
disp(norm(xr' - x) < 1e-10);
%cz 2
f1 = f1 + 2.5;
f2 = f2 + 2.5;
f3 = f3 + 2.5;

x = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);

%an
y = A*x';
%re
xr = S*y;

figure; stem(f, abs(y)); title('Analiza DCT po zwiększeniu częstotliwości o 2.5 Hz');
xlabel('Częstotliwość (Hz)'); ylabel('|DCT|');

disp('Czy rekonstrukcja jest perfekcyjna po zwiększeniu wszystkich częstotliwości o 2.5 Hz?');
disp(norm(xr' - x) < 1e-10);

%plot(y);