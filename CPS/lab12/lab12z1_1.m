clear all; close all;
% Wczytanie obrazu
im1 = imread('im1.png');
% Konwersja do skali szarości, jeśli to konieczne
if size(im1, 3) == 3
    im1 = rgb2gray(im1);
end
% Obliczenie DCT2
dct_im1 = dct2(im1);

% Wyświetlenie wyniku
figure;
imshow(log(abs(dct_im1)),[]);
title('DCT2 obrazu im1');
% Kopiowanie DCT obrazu
dct_im1_mod = dct_im1;

% Znalezienie współczynnika DC
[M, N] = size(dct_im1);
dct_im1_mod(2:M, 2:N) = 0; % Wyzerowanie współczynników (połowa znaczących)

% Odwrotna DCT2
idct_im1 = idct2(dct_im1_mod);

% Wyświetlenie oryginalnego i zmodyfikowanego obrazu
figure;
subplot(1,2,1);
imshow(im1,[]);
title('Oryginalny obraz');
subplot(1,2,2);
imshow(idct_im1,[]);
title('Obraz po modyfikacji DCT2');

%% Wczytanie obrazu
cameraman = imread('cameraman.tif');

% Obliczenie DCT2
dct_cameraman = dct2(cameraman);
% Wyświetlenie wyniku
figure;
imshow(log(abs(dct_cameraman)), []);
title('DCT2 obrazu cameraman');

% Wyzerowanie współczynników wysokich częstotliwości
threshold = 50;
dct_cameraman(abs(dct_cameraman) < threshold) = 0;
% Odwrotna DCT2
idct_cameraman = idct2(dct_cameraman);

% Wyświetlenie obrazu po modyfikacji
figure;
subplot(1,2,1);
imshow(cameraman, []);
title('Oryginalny');
subplot(1,2,2);
imshow(idct_cameraman, []);
title('Obraz cameraman po modyfikacji DCT2');


%% Samodzielne generowanie obrazu sumarycznego
im_sum = zeros(128, 128);
% Generowanie obrazów bazowych i sumowanie
IM1 = zeros(128, 128);
IM1(2, 10) = 1;
im1 = idct2(IM1);
im_sum = im_sum + im1;

IM2 = zeros(128, 128);
IM2(4, 10) = 1;
im2 = idct2(IM2);
im_sum = im_sum + im2;

IM3 = zeros(128, 128);
IM3(8, 10) = 1;
im3 = idct2(IM3);
im_sum = im_sum + im3;

% Wyświetlenie obrazów bazowych i sumarycznego
figure;
subplot(2,2,1);
imshow(im1, []);
title('Obraz bazowy 1');
subplot(2,2,2);
imshow(im2, []);
title('Obraz bazowy 2');
subplot(2,2,3);
imshow(im3, []);
title('Obraz bazowy 3');
subplot(2,2,4);
imshow(im_sum, []);
title('Obraz sumaryczny');

%% Obliczenie DCT2 obrazu sumarycznego
dct_sum = dct2(im_sum);
% Wyświetlenie wyniku jako obraz
figure;
imshow(log(abs(dct_sum)), []);
title('DCT2 obrazu sumarycznego');

% Kopiowanie DCT sumarycznego obrazu
dct_sum_mod = dct_sum;
% Zachowanie jednego współczynnika
dct_sum_mod(4:end, :) = 0;
dct_sum_mod(:, 4:end) = 0;
% Odwrotna DCT2
idct_sum_mod = idct2(dct_sum_mod);
% Wyświetlenie obrazu
figure;
imshow(idct_sum_mod, []);
title('Obraz po pozostawieniu jednego współczynnika DCT2');

%% Wczytanie obrazu
im2 = imread('im2.png');
figure;
imshow(im2);
title('im2');
% Konwersja do skali szarości, jeśli to konieczne
if size(im2, 3) == 3
    im2 = rgb2gray(im2);
end
% Obliczenie DCT2
dct_im2 = dct2(im2);
% Wyświetlenie wyniku
figure;
imshow(log(abs(dct_im2)), []);
title('DCT2 obrazu im2');
% Analiza wyglądu współczynników DCT2
% Współczynniki DCT mają tendencję do koncentracji energii obrazu
% w lewym górnym rogu, gdzie znajdują się współczynniki 
% niskiej częstotliwości. 
% Jeśli obraz zawiera dużo niskich częstotliwości (np. gładkie przejścia), większość energii będzie skoncentrowana w tym obszarze.
% Wysokie częstotliwości reprezentują 
% szybkie zmiany w intensywności pikseli. 
% Jeśli obraz zawiera dużo szczegółów i krawędzi, 
% współczynniki wysokiej częstotliwości będą miały większe 
% wartości.

%Współczynniki DCT mogą wykazywać pewne wzory lub symetrię w 
% zależności od struktury obrazu. Na przykład, obrazy o regularnych 
% wzorach mogą mieć regularne rozmieszczenie istotnych współczynników.
