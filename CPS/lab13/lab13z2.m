clear all; close all; clc;

% Wczytanie obrazów
%imgI = imread('L188Undistorted.png');
%imgP = imread('P188Undistorted.png');
imgI = imread('IMGP4955_Easy-Resize.com.JPG');
imgP = imread('IMGP4956_Easy-Resize.com.JPG');

figure;
subplot(1,2,1);
imshow(imgI,[]);
subplot(1,2,2);
imshow(imgP,[]);

if size(imgI, 3) == 3
    imgI = rgb2gray(imgI);
end
if size(imgP, 3) == 3
    imgP = rgb2gray(imgP);
end

%parametry
mbSize = 12;  % rozmiar bloku
p = 64;      % zakres poszukiwania

% Wyznaczenie wektorów ruchu
motionVect = motionEstES(imgP, imgI, mbSize, p);

%rysowanie
figure;
imshow(imgI); hold on;
quiver(motionVect(2, :), motionVect(1, :), motionVect(4, :), motionVect(3, :), 'r');
title('Wektory ruchu');
hold off;


function [motionVect] = motionEstES(imgP, imgI, mbSize, p)
    % Wyznaczenie wektorow ruchu metoda pelnego przeszukiwania;
    % imgP - obraz dla ktorego szukamy wektorow ruchu;
    % imgI - obraz odniesienia;
    % mbSize - rozmiar bloku;
    % p - zakres poszukiwania;
    % motionVect - wektory ruchu dla kolejnych blokow w kolejnosci od lewej do prawej i z gory na dol;

    [row, col] = size(imgI);
    row = floor(row / mbSize) * mbSize;
    col = floor(col / mbSize) * mbSize;

    vectors = zeros(4, (row * col) / mbSize^2);
    mbCount = 1;
    
    for i = 1 : mbSize : row
        for j = 1 : mbSize : col
            cost = 10^20;
            pos = [0 0];
            for m = -p : p
                for n = -p : p
                    refBlkVer = i + m; % wiersz/wspolrzedna pionowa;
                    refBlkHor = j + n; % kolumna/wspolrzedna pozioma;
                    if ( refBlkVer < 1 || refBlkVer + mbSize - 1 > row || refBlkHor < 1 || refBlkHor + mbSize - 1 > col)
                        continue;
                    end
                    % wyznaczenie kosztu:
                    temp_cost = sum(sum(abs(imgP(i:i+mbSize-1, j:j+mbSize-1) - imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1))));
                    if (temp_cost < cost)
                        cost = temp_cost;
                        pos = [m n];
                    end
                end
            end
            vectors(1, mbCount) = i;
            vectors(2, mbCount) = j;
            vectors(3, mbCount) = pos(1); % wiersz/wspolrzedna pionowa
            vectors(4, mbCount) = pos(2); % kolumna/wspolrzedna pozioma
            mbCount = mbCount + 1;
        end
    end
    motionVect = vectors;
end

