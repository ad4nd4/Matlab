% svd_image.m
clear all; close all;

[X, map] = imread('lena512.bmp');         % wczytaj obraz
wymiary = size(X); 

X = double(X);                           % pokaz go
image(X); title('Oryginal');
colormap(map); axis image off; 

[U, S, V] = svd(X);                      % zrob dekompozycje SVD
image(U * S * V'); title('SVD');         % odtworz obraz ze wszystkich skladowych
colormap(map); axis image off;

% Pętla dla różnych ilości osobliwych
mv = [1, 2, 3, 4, 5, 10, 15, 20, 25, 50];
errors = zeros(1, length(mv));
compression_ratios = zeros(1, length(mv));

for i = 1:length(mv)                     % PETLA - START
    mask = zeros(size(S));               % maska zerująca wartości osobliwe (w.o.)
    mask(1:mv(i), 1:mv(i)) = 1;          % wstaw "1" pozostawiajace najwieksze w.o. 

    % Synteza i pokaz obrazu zrekonstruowanego
    reconstructed_image = U * (S .* mask) * V';
    figure; image(reconstructed_image);
    colormap(map); axis image off;       % bez osi
    
    % Obliczenie różnicy między oryginalnym a odtworzonym obrazem
    diff_image = X - reconstructed_image;
    % Obliczenie średniego błędu
    mean_error = mean(diff_image(:));
    errors(i) = mean_error;
    % Analiza kompresji obrazu
    compression_ratio = numel(S) / (numel(U) + numel(S) + numel(V));
    compression_ratios(i) = compression_ratio;
    
    fprintf('Liczba osobliwych: %d, Błąd: %f, Kompresja: %f\n', mv(i), mean_error, compression_ratio);
    input('Naciśnij Enter, aby kontynuować...');
end                                      % PETLA - STOP

% Wykres zmienności średniego błędu
figure;
plot(mv, errors, 'o-', 'LineWidth', 2);
title('Zmienność średniego błędu w zależności od liczby osobliwych');
xlabel('Liczba osobliwych');
ylabel('Średni błąd rekonstrukcji');
grid on;

% wykres zmienności stopnia kompresji
figure;
plot(mv, compression_ratios, 'o-', 'LineWidth', 2);
title('Zmienność stopnia kompresji w zależności od liczby osobliwych');
xlabel('Liczba osobliwych');
ylabel('Stopień kompresji');
grid on;
pause;
%Analizując ten wykres, można zauważyć, które wartości osobliwe są 
% dominujące (o dużej wartości) i które przestają mieć istotne znaczenie. 
% W praktyce, wybór liczby osobliwych do uwzględnienia w rekonstrukcji 
% obrazu może być oparty na progu wartości osobliwej. 
% Im wyższy próg, tym mniejsza liczba osobliwych jest brana pod uwagę, co prowadzi do większej kompresji.