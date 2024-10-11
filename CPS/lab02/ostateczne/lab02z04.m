clear all; close all;

[x, fs] = audioread('mowa.wav');

figure;
plot(x);
xlabel('Numer próbki');
ylabel('Amplituda');
title('Sygnał mowy');

N = 256;
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

M = 10;
for k = 1:M
    n1 = randi([1, length(x) - N + 1]);
    n2 = n1 + N - 1;
    xk = x(n1:n2);

    yk = A * xk;
    
    % Skalowanie osi x na herce
    f = (0:N-1) * fs / N / 2;
    
    figure;
    subplot(2, 1, 1);
    plot(xk);
    title(['Fragment sygnału mowy ' num2str(k)]);
    xlabel('Numer próbki');
    ylabel('Amplituda');
    
    subplot(2, 1, 2);
    stem(f, abs(yk));
    title(['Analiza DCT fragmentu ' num2str(k)]);
    xlabel('Częstotliwość [Hz]');
    ylabel('|DCT|');
    pause(0.2);
end
