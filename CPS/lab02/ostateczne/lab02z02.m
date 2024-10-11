clear all; close all;
%poczatek to powtorka z rozrywki, tle ze tu uzywam macierzy s ktora jest
%transponowana macierza A, czyli ma zamienione komulny z wierszami.
%uzywam wizualizacji kolorami, ale w kodzie mam tez wartosci (-0 to bardzo bliska 0 wartosc, ale ponizej)
N = 20;
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

S = A'; % Transpozycja macierzy A

% Sprawdzenie, czy SA == I (macierz identycznościowa)
I = S * A;
%disp('Macierz SA:');
%disp(I);
mesh(I);
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

%gen. sygn.
x = randn(N, 1);

%Analiza
X = A * x;

%Rekonstrukcja
xs = S * X; %jestesmy w stanie odtworzyc sygnal na podstawie uzycia macierzy odwrotniej, co ma sens, bo to jakbysmy dzielili

%i tu wlasnie jest ta rekonstrukcja, no i jak roznica miedzy macierzami
%jest mniejsza niz blad to jest ok
if all(abs(xs - x) < 1e-10)
    disp('Transformacja posiada właściwość perfekcyjnej rekonstrukcji.');
else
    disp('Transformacja nie posiada właściwości perfekcyjnej rekonstrukcji.');
end
