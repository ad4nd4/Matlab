clc; clear all; close all;

N = 256;
[x, fs] = audioread('mowa.wav');
probki = [64, 581, 1603, 9370, 10502, 13908, 16505, 20027, 26786, 31209];
M = length(probki);

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

for k = 1:M
    xk = x(probki(k):probki(k)+N-1);
    yk = A * xk;

    f = (0:N-1)*fs/N;
    figure;
    subplot(2, 1, 1);
    plot(xk);
    title(['Fragment sygnału mowy ' num2str(k)]);
    xlabel('Numer próbki');
    ylabel('Amplituda');
    
    subplot(2, 1, 2);
    stem(f, abs(yk), 'filled');
    title(['Analiza DCT fragmentu ' num2str(k)]);
    xlabel('Częstotliwość [Hz]');
    ylabel('|DCT|');
    pause(0.2);
end