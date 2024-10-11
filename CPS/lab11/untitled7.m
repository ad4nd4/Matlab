% Wczytaj próbkę audio
[x, fs] = audioread('DontWorryBeHappy.wav');

% Okno czasowe (np. Kaiser-Bessel-derived)
win = kbdwin(2048);

% Oblicz MDCT
C = mdct(x, win);

% Transformuj reprezentację z powrotem do dziedziny czasu
y = imdct(C, win);

% Porównaj oryginalny sygnał z odtworzonym
figure;
t = (0:size(x, 1) - 1) / fs;
plot(t, x, 'bo', t, y, 'r.');
legend('Oryginalny Sygnał', 'Odtworzony Sygnał');
title('Reconstruction Error');
xlabel('Czas (s)');
ylabel('Amplituda');
