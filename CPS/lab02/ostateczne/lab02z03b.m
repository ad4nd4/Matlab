clear all; close all;

N = 100;
fs = 1000;
dt = 1/fs;
t = (0:N-1)*dt;

f1 = 50; A1 = 50;
f2 = 100; A2 = 100;
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

for k=1:N
    figure(1);
    subplot(2,1,1);
    plot(A(k,:), 'DisplayName', sprintf('Wiersz A %d', k));
    title(sprintf('Wiersz %d macierzy A', k));
    subplot(2,1,2);
    plot(S(:,k), 'DisplayName', sprintf('Kolumna S %d', k));
    title(sprintf('Kolumna %d macierzy S', k));
    pause(0.1);
end

%skalowanie
f = (0:N-1)*fs/N/2;

%wsp
figure(2);
stem(f, abs(y), 'filled');
title('Współczynniki DCT sygnału');
xlabel('Częstotliwość [Hz]');
ylabel('Amplituda');

error = max(abs(xr'-x));
if error < 1e-10
    disp('Sygnał został perfekcyjnie zrekonstruowany.');
else
    disp(['Rekonstrukcja nie jest perfekcyjna. Maksymalny błąd: ', num2str(error)]);
end


figure;
plot(t, x, 'DisplayName', 'Oryginalny sygnał x'); hold on;
plot(t, xr, '--', 'DisplayName', 'Zrekonstruowany sygnał xr');
legend show;
title('Porównanie sygnału oryginalnego i zrekonstruowanego');
xlabel('Czas [s]'); ylabel('Amplituda');
