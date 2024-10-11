clear all;
close all;

% Wczytanie próbki dźwiękowej
[x,Fs] = audioread('DontWorryBeHappy.wav', 'native');
x = double(x);

% KODER
a = 0.9545; % parametr a kodera
d = x - a*[[0,0]; x(1:end-1,:)]; % KODER dla pojedynczego kanału

% KWANTYZACJA
ile_bitow = 4; % rozdzielczość sygnału w bitach - ilość stanów 2^n = 16 stanów
dq = lab11_kwant(d, ile_bitow); % kwantyzator

% DEKODER
% Dekodowanie sygnału nieskwantyzowanego
y = zeros(size(x));
y(1) = d(1); % inicjalizacja pierwszego elementu
for k = 2:length(d)
    y(k) = d(k) + a*y(k-1);
end

% Dekodowanie sygnału z kwantyzacją
ydq = zeros(size(dq));
ydq(1) = dq(1); % inicjalizacja pierwszego elementu
for k = 2:length(dq)
    ydq(k) = dq(k) + a*ydq(k-1);
end

% Wykresy (po dekodowaniu)
n = 1:length(x);

figure;
subplot(2,1,1);
hold all;
plot(n, x, 'b');
plot(n, y, 'r');
title('Zdekodowany sygnał'); legend('Oryginalny','Zdekodowany');

subplot(2,1,2);
hold all;
plot(n, x, 'b');
plot(n, ydq, 'r');
title('Zdekodowany sygnał (z kwantyzacją)'); legend('Oryginalny','Zdekodowany z kwantyzacją');

% Obliczenie i wyświetlenie błędów rekonstrukcji
err_nie_zw = abs(max(x - y'));
err_kwant = abs(max(x - ydq'));

disp('Różnica między oryginałem a odtworzonym:');
disp(err_nie_zw);
disp('Różnica między oryginałem skwantowanym a odtworzonym:');
disp(err_kwant);

% Odtwarzanie dźwięku
soundsc(ydq, Fs); % odtwarzamy zrekonstruowany sygnał z kwantyzacją

% Funkcja do kwantyzacji
function dq = lab11_kwant(d, ile_bitow)
    % Funkcja do kwantyzacji sygnału d do ilości stanów 2^ile_bitow
    min_d = min(d);
    max_d = max(d);
    step = (max_d - min_d) / (2^ile_bitow - 1); % krok kwantyzacji
    dq = round((d - min_d) / step) * step + min_d;
end
