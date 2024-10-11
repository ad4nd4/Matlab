clear all; close all;

% Parametry
K = 32;     % rozmiar bloku dla jednego bitu znaku wodnego (zmniejszony)
wzm = 1;    % wzmocnienie znaku wodnego

% Wczytaj obraz do znakowania
A = imread('lena512.png');
B = double(A); [M, N] = size(B);

% Dodanie znaku wodnego w dziedzinie DCT
Mb = (M/K); Nb=(N/K);                 % liczba bloków w wierszu i kolumnie
plusminus1 = sign( randn(1,Mb*Nb) );  % losowa sekwencja liczb +1/-1
Znak = zeros( size(B) );              % macierz znaku: szachownica z jakimś wzorkiem +1/-1
for i = 1:Mb
    for j = 1:Nb
        Znak( (i-1)*K+1 : i*K, (j-1)*K+1 : j*K ) = plusminus1((i-1)*Nb + j);
    end
end
Sz = round( randn(size(B)) );         % szum (nośna modulująca znak)
ZnakSz = wzm * Sz .* Znak;            % modulacja znaku wodnego = wzm * szum * znak(+/-1)

% Podział obrazu na bloki 16x16 i transformacja DCT
B_dct = zeros(size(B));
for i = 1:K:M
    for j = 1:K:N
        block = B(i:i+K-1, j:j+K-1);
        dct_block = dct2(block);
        % Dodanie znaku wodnego do współczynników DCT
        dct_block = dct_block + ZnakSz(i:i+K-1, j:j+K-1);
        B_dct(i:i+K-1, j:j+K-1) = dct_block;
    end
end

% Odwrotna transformacja DCT
B_watermarked = zeros(size(B));
for i = 1:K:M
    for j = 1:K:N
        dct_block = B_dct(i:i+K-1, j:j+K-1);
        block = idct2(dct_block);
        B_watermarked(i:i+K-1, j:j+K-1) = block;
    end
end

B_watermarked = uint8(B_watermarked);

% Rysunki
figure, subplot(1,2,1), imshow(Znak,[]); title('Znak wodny')
subplot(1,2,2), imshow(ZnakSz,[]); title('Znak zmodulowany szumem')
figure, subplot(1,2,1); imshow(A,[]); title('Obraz oryginalny')
subplot(1,2,2); imshow(B_watermarked,[]); title('Obraz z ukrytym znakiem wodnym')
% Detekcja znaku wodnego =================
angles = [0, 10, 30, 45, 60, 90];  % kąty rotacji w stopniach
correct_detection = zeros(size(angles));

for idx = 1:length(angles)
    angle = angles(idx);
    B_rotated = imrotate(B_watermarked, angle, 'bilinear', 'crop');
    B_rotated = imresize(B_rotated, [M N]);  % przywrócenie do oryginalnego rozmiaru
    B_rotated = double(B_rotated);  % powrotna konwersja do podwójnej precyzji
    
    % Podział zrotowanego obrazu na bloki 16x16 i transformacja DCT
    B_dct_rotated = zeros(size(B_rotated));
    for i = 1:K:M
        for j = 1:K:N
            block = B_rotated(i:i+K-1, j:j+K-1);
            dct_block = dct2(block);
            B_dct_rotated(i:i+K-1, j:j+K-1) = dct_block;
        end
    end

    % Detekcja znaku wodnego
    Demod_rotated = B_dct_rotated .* Sz;  % demodulacja
    ZnakDetekt_rotated = zeros(size(B_rotated));
    for i = 1:Mb
        for j = 1:Nb
            ZnakDetekt_rotated((i-1)*K+1:i*K, (j-1)*K+1:j*K) = ...
                sign(sum(sum(Demod_rotated((i-1)*K+1:i*K, (j-1)*K+1:j*K))));
        end
    end
    correct_detection(idx) = sum(sum(Znak == ZnakDetekt_rotated)) / numel(Znak);
end

figure;
plot(angles, correct_detection * 100, '-o');
xlabel('Kąt rotacji (stopnie)');
ylabel('Procent poprawnie wykrytych znaków wodnych');
title('Odporność na rotację w dziedzinie DCT');
