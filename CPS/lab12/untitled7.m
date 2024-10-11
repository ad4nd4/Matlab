close all; clear all; clc;

% Wczytanie obrazu
I = imread('car1.jpg'); 

% Przejście do skali szarości
I1 = double(rgb2gray(I));
figure;
imshow(I1, []);
title('I1 - bazowy');

% Filtracja wstępna: generowanie maski filtru Gaussa
%h = fspecial('gaussian', [32, 32], 3);
h =  fspecial('laplacian', 0.8);
I2 = imfilter(I1, h);
figure;
imshow(I2, []);
title('I2 - po filtracji wstępnej');

% Kwantyzacja po filtracji [0 255]
I2 = mat2gray(I2) * 255;
I2 = quant(I2,1);

% Dobór progu za pomocą imcontrast
figure; imshow(I2, []);
imcontrast; %suwak

lt = 195;  % dolny próg binaryzacji
ut = 199;  % górny próg binaryzacji
% Binaryzacja
B1 = I2;
B1(B1 < lt) = 0; % usunięcie pikseli o wartościach mniejszych od lt
B1(B1 > ut) = 0; % usunięcie pikseli o wartościach większych od ut
B1(B1 > 0) = 1; % przypisanie pozostałym wartościom 1
figure; imshow(B1, []); title('B1 - po binaryzacji');

% Operacje morfologiczne
B1 = bwmorph(B1, 'dilate', 1);
figure; imshow(B1, []); title('B1 - po operacji morfologicznej dylatacji');
B1 = bwmorph(B1, 'erode', 1);
figure; imshow(B1, []); title('B1 - po operacji morfologicznej erozji');
B1 = imfill(B1, 'holes');
figure; imshow(B1, []); title('B1 - po operacji morfologicznej wypełniania');
B1 = bwareaopen(B1, 3); % usunięcie elementów o powierzchni mniejszej niż 50 pikseli
figure; imshow(B1, []); title('B1 - po usunięciu małych elementów');

Isob = edge(B1, 'sobel');
figure; imshow(Isob, []); title('Detekcja krawędzi filtrem Sobela');

Iprew = edge(B1, 'prewitt');
figure; imshow(Iprew, []); title('Detekcja krawędzi filtrem Prewitta');

Ican = edge(B1, 'canny');
figure; imshow(Ican, []); title('Detekcja krawędzi filtrem Cannego');
 
% który przypuszczalnie jest tablicą rejestracyjną
% B2 = bwpropfilt(B1, 'Area', 1);
% figure; imshow(B2, []); title('Największy obiekt - tablica rejestracyjna');
