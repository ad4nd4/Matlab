clear all; close all;
%składowa o częstotliwości 105 Hz jest rozmyta. 
% Oznacza to, że nie ma ona bezpośredniego odwzorowania w zestawie funkcji 
% bazowych macierzy DCT, które są dostrojone do 
% harmonicznych sygnału o częstotliwościach wielokrotności fs/N
N = 100;
fs = 1000;
dt = 1/fs;
t = (0:N-1)*dt;

f1 = 50; A1 = 50;
f2 = 105; A2 = 100; % Zmiana częstotliwości na 105 Hz
f3 = 150; A3 = 150;

x = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);

A = zeros(N, N);
for k = 0:N-1
    for n = 0:N-1
        if k == 0
            sk = 1 / sqrt(N);
        else
            sk = sqrt(2 / N);
        end
        A(k+1, n+1) = sk * cos(pi * k / N * (n + 0.5));
    end
end
S = A';
y = A*x';
xr = S*y;
f = (0:N-1)*fs/N/2;

figure;
stem(f, abs(y), 'filled');
title('Współczynniki DCT sygnału po zmianie częstotliwości na 105 Hz');
xlabel('Częstotliwość [Hz]');
ylabel('Amplituda');

error = max(abs(xr'-x));
if error < 1e-10
    disp('Sygnał został perfekcyjnie zrekonstruowany.');
else
    disp(['Rekonstrukcja nie jest perfekcyjna. Maksymalny błąd: ', num2str(error)]);
end
