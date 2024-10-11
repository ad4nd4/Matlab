clear all; close all;

Ax = sqrt(2) * 230;  % nominalna amplituda sygnału
fx = 50;  % nominalna częstotliwość sygnału
Nx = 100;  % liczba próbek na jeden okres
n = 0:Nx-1;  % indeksy próbek
fpr = Nx * fx;  % częstotliwość próbkowania (100 razy większa niż fx)

for iter = 1 : 10000
    x = Ax * sin(2*pi*(fx + 1/3 * randn())/(Nx * fx) * n + rand() * 2*pi);  % sygnał
    x = awgn(x, 60);  % dodanie szumu, SNR = 60 dB

    % Estymator #1
    xsk1(iter) = sqrt(sum(x.^2) / Nx);

    % Estymator #2
    xsk2(iter) = max(abs(x)) / sqrt(2);
end

% Wyświetlanie histogramów
subplot(211);
hist(xsk1, 30);
grid;
xlabel('xsk1');
title('Histogram estymatora #1');

subplot(212);
hist(xsk2, 30);
grid;
xlabel('xsk2');
title('Histogram estymatora #2');
