% ---------------------------------------------------------------------------------------
% Tabela 22-10 (str. 717)
% �wiczenie: Wprowadzanie znak�w wodnych do obraz�w cyfrowych metod� widma rozproszonego
% ---------------------------------------------------------------------------------------

clear all; close all;

% Parametry
K = 16;     % rozmiar bloku dla jednego bitu znaku wodnego (zmniejszony)
wzm = 1;    % wzmocnienie znaku wodnego

% Wczytaj obraz do znakowania
A = imread('lena512.png');
B = double(A); [M, N] = size(B);

% Dodanie znaku wodnego==================
Mb = (M/K); Nb=(N/K);                 % liczba bloków w wierszu i kolumnie
plusminus1 = sign( randn(1,Mb*Nb) );  % losowa sekwencja liczb +1/-1
Znak = zeros( size(B) );              % macierz znaku: szachownica z jakimś wzorkiem +1/-1
for i = 1:Mb
    for j = 1:Nb
        Znak( (i-1)*K+1 : i*K, (j-1)*K+1 : j*K ) = plusminus1(i*j);
    end
end
Sz = round( randn(size(B)) );         % szum (nośna modulująca znak)
ZnakSz = wzm * Sz .* Znak;            % modulacja znaku wodnego = wzm * szum * znak(+/-1)
B = uint8( B + ZnakSz );              % obraz + znak wodny, konwersja do 8 bitów

% Rysunki
figure, subplot(1,2,1), imshow(Znak,[]);   title('Znak wodny')
subplot(1,2,2), imshow(ZnakSz,[]); title('Znak zmodulowany szumem')
figure, subplot(1,2,1); imshow(A,[]);      title('Obraz oryginalny')
subplot(1,2,2); imshow(B,[]);      title('Obraz z ukrytym znakiem wodnym')

B_watermarked = uint8(B_watermarked);

% Rysunki
figure, subplot(1,2,1), imshow(Znak,[]); title('Znak wodny')
subplot(1,2,2), imshow(ZnakSz,[]); title('Znak zmodulowany szumem')
figure, subplot(1,2,1); imshow(A,[]); title('Obraz oryginalny')
subplot(1,2,2); imshow(B_watermarked,[]); title('Obraz z ukrytym znakiem wodnym')
% Detekcja znaku wodnego =================
B = double(B);                              % powrotna konwersja do podwójnej precyzji

% Filtracja górnoprzepustowa zaznaczonego obrazu
L = 10; L2=2*L+1;                           % rozmiar filtra 2D (L x L)
w = hamming(L2); w = w * w';                % okno 2D z okna 1D Hamminga

f0=0.5; wc = pi*f0; [m n] = meshgrid(-L:L,-L:L);                         %  filtr LowPass
lp = wc * besselj( 1, wc*sqrt(m.^2 + n.^2) )./(2*pi*sqrt(m.^2 + n.^2) ); %
lp(L+1,L+1)= wc^2/(4*pi);                                                %
hp = - lp; hp(L+1,L+1) = 1 - lp(L+1,L+1);   % filtr HighPass z LowPass (bez okna 2D)
h = hp .* w;                                % z oknem 2D
B = conv2( B, h, 'same');                   % filtracja obrazu

% Decyzja o wartości bitu w każdym bloku (+1/-1)
Demod = B .* Sz;                            % demodulacja
ZnakDetekt = zeros( size(B) );              % sumowanie pikseli w blokach
for i=1:Mb
    for j=1:Nb
        ZnakDetekt((i-1)*K+1:i*K, (j-1)*K+1:j*K) = ...
            sign( sum( sum( Demod((i-1)*K+1:i*K, (j-1)*K+1:j*K) ) ) );
    end
end
blad_detekcji = sum(sum( abs(Znak-ZnakDetekt) ))

% Rysunki
figure, subplot(1,2,1); imshow(Demod,[]);      title('Demodulacja')
subplot(1,2,2); imshow(ZnakDetekt,[]); title('Detekcja znaku')

% Sprawdzenie odporności na skalowanie
scale_factors = linspace(1, 0.1, 10);
correct_detection = zeros(size(scale_factors));

for idx = 1:length(scale_factors)
    scale_factor = scale_factors(idx);
    B_scaled = imresize(B, scale_factor, 'bilinear');
    B_resized = imresize(B_scaled, [M N], 'bilinear');
    B_resized = double(B_resized);  % powrotna konwersja do podwójnej precyzji
    
    % Filtracja górnoprzepustowa zaznaczonego obrazu
    B_resized = conv2(B_resized, h, 'same');
    %B_resized = fspecial('laplacian', 0.2);
    % Decyzja o wartości bitu w każdym bloku (+1/-1)
    Demod_resized = B_resized .* Sz;  % demodulacja
    ZnakDetekt_resized = zeros(size(B_resized));
    for i = 1:Mb
        for j = 1:Nb
            ZnakDetekt_resized((i-1)*K+1:i*K, (j-1)*K+1:j*K) = ...
                sign(sum(sum(Demod_resized((i-1)*K+1:i*K, (j-1)*K+1:j*K))));
        end
    end
    correct_detection(idx) = 1 - sum(sum(abs(Znak - ZnakDetekt_resized))) / numel(Znak);
end

figure;
plot(scale_factors * 100, correct_detection * 100, '-o');
xlabel('Procent oryginalnej rozdzielczości');
ylabel('Procent poprawnie wykrytych znaków wodnych');
title('Odporność na skalowanie');

% Sprawdzenie odporności na kompresję stratną JPEG (0.25)
quality_factors = 10:10:100;
correct_detection_jpeg = zeros(size(quality_factors));

for idx = 1:length(quality_factors)
    quality_factor = quality_factors(idx);
    imwrite(uint8(B), 'temp.jpg', 'Quality', quality_factor);
    B_jpeg = imread('temp.jpg');
    B_jpeg = double(B_jpeg);
    
    % Filtracja górnoprzepustowa zaznaczonego obrazu
    B_jpeg = conv2(B_jpeg, h, 'same');
    
    % Decyzja o wartości bitu w każdym bloku (+1/-1)
    Demod_jpeg = B_jpeg .* Sz;  % demodulacja
    ZnakDetekt_jpeg = zeros(size(B_jpeg));
    for i = 1:Mb
        for j = 1:Nb
            ZnakDetekt_jpeg((i-1)*K+1:i*K, (j-1)*K+1:j*K) = ...
                sign(sum(sum(Demod_jpeg((i-1)*K+1:i*K, (j-1)*K+1:j*K))));
        end
    end
    correct_detection_jpeg(idx) = 1 - sum(sum(abs(Znak - ZnakDetekt_jpeg))) / numel(Znak);
end

figure;
plot(quality_factors, correct_detection_jpeg * 100, '-o');
xlabel('Jakość kompresji JPEG');
ylabel('Procent poprawnie wykrytych znaków wodnych');
title('Odporność na kompresję stratną JPEG');
