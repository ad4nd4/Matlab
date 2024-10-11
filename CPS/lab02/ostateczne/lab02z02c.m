clear all; close all;
%sygnal jest losowy, a przesuniete indeksy potegują błedy.
N = 20;
n = 0:N-1;

k = (0:N-1) + 0.25; % Zmodyfikowane indeksy
A = sqrt(2/N) * cos(pi * (k' + 0.5) * (n + 0.5) / N);
S = A';
I = A * S;

figure;
imagesc(I);
title('Wizualizacja I = SA');
colorbar; colormap('jet'); axis square;

xlabel('Indeks kolumny'); ylabel('Indeks wiersza');

%macierz identycznosciowa to eye (jedynki na przekatnej)
if all(all(abs(I - eye(N)) < 1e-10))
    disp('Macierz I = SA jest bardzo bliska macierzy identycznościowej.');
else
    disp('Macierz I = SA nie jest bliska macierzy identycznościowej.');
end

%szumowy
x_noise = randn(N, 1);
%harmoniczny
f = 5;
t = (0:N-1) / N;
x_harmonic = sin(2*pi*f*t)';

%analiza
X_noise = A * x_noise;
X_harmonic = A * x_harmonic;

%synteza (rekonstrukcja)
x_noise_rec = S * X_noise;
x_harmonic_rec = S * X_harmonic;

%errory
error_noise = norm(x_noise - x_noise_rec);
error_harmonic = norm(x_harmonic - x_harmonic_rec);

disp(['Błąd rekonstrukcji dla sygnału szumowego: ', num2str(error_noise)]);
if all(abs(x_noise_rec - x_noise) < 1e-10)
    disp('Transformacja posiada właściwość perfekcyjnej rekonstrukcji.');
else
    disp('Transformacja nie posiada właściwości perfekcyjnej rekonstrukcji.');
end

disp(['Błąd rekonstrukcji dla sygnału harmonicznego: ', num2str(error_harmonic)]);
if all(abs(x_harmonic_rec - x_harmonic) < 1e-10)
    disp('Transformacja posiada właściwość perfekcyjnej rekonstrukcji.');
else
    disp('Transformacja nie posiada właściwości perfekcyjnej rekonstrukcji.');
end
