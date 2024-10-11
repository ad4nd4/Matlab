clear all; close all;

N = 100; 
fs = 1000;
dt = 1/fs;
t = (0:N-1)*dt; % wzor, dt to odstep czasowy

f1 = 50; A1 = 50;
f2 = 100; A2 = 100;
f3 = 150; A3 = 150;

x = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);

A = zeros(N, N);
for k = 0:N-1
    for n = 0:N-1
        if k == 0
            sk = 1 / sqrt(N); %cos0
        else
            sk = sqrt(2 / N);
        end
        A(k+1, n+1) = sk * cos(pi * k / N * (n + 0.5));
    end
end
S = A';

figure;
for k=1:N
    subplot(2,1,1);
    plot(A(k,:), 'DisplayName', sprintf('Wiersz A %d', k));
    title(sprintf('Wiersz %d macierzy A', k));
    subplot(2,1,2);
    plot(S(:,k), 'DisplayName', sprintf('Kolumna S %d', k));
    title(sprintf('Kolumna %d macierzy S', k));
    pause(0.1);
end
%analiza
y = A*x';
xr = S*y;
%wsp
figure;
stem(1:N, y, 'filled');
title('Współczynniki DCT sygnału');
xlabel('Numer współczynnika');
ylabel('Amplituda');

if max(abs(xr'-x)) < 1e-10
    disp('Sygnał został perfekcyjnie zrekonstruowany.');
else
    disp('Rekonstrukcja nie jest perfekcyjna.');
end

