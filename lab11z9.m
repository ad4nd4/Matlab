% csp_11_fmdemod.m - demodulacja sygnału FM z użyciem filtra Hilberta
clear all; close all;

% Parametry
K = 1; % opcjonalne K-krotne nad-próbkowanie sygnału mowy 44.1 kHz
fc = 7500; % częstotliwość nośna (Hz)
M = 200; N = 2*M+1; % N = 2M+1 = długość projektowanych filtrów FIR
fmax = 4000; % założona maksymalna częstotliwość mowy (Hz)
DF = 5000; % 2*DF = wymagane pasmo sygnału z modulacją FM (Hz)
kf = (DF/fmax-1)*fmax; % indeks modulacji z reguły Carsona

% Wczytaj sygnał radia FM, modulujący nośną
[x, fx] = audioread('speech44100.wav', [1, 1*44100]); % próbki [od, do]
soundsc(x, fx); x = x'; % posłuchaj
x = resample(x, K, 1); fs = K * fx; % opcjonalnie nad-próbkuj
Nx = length(x); dt = 1/fs; t = dt*(0:Nx-1); % używane zmienne

% Wyświetlanie oryginalnego sygnału
figure;
subplot(211); plot(t, x); grid; xlabel('t (s)'); title('x(t) - Original Signal');
subplot(212); spectrogram(x, 256, 192, 512, fs, 'yaxis'); title('STFT(1) - Spectrogram of Original Signal'); pause

% Modulacja FM
y = cos(2*pi*(fc*t + kf*cumsum(x)*dt)); % sygnał zmodulowany w częstotliwości (FM)
figure; spectrogram(y, 256, 192, 512, fs, 'yaxis'); title('STFT(2) - Spectrogram of FM Modulated Signal'); pause

% Obliczanie sygnału analitycznego za pomocą filtra Hilberta
ya = hilbert(y); % obliczanie sygnału analitycznego

% Alternatywna demodulacja sygnału FM
inst_phase = unwrap(angle(ya)); % faza chwilowa sygnału analitycznego
inst_freq = diff(inst_phase) / (2*pi*dt); % różniczkowanie fazy w celu uzyskania częstotliwości chwilowej
inst_freq = [inst_freq, inst_freq(end)]; % wyrównanie długości sygnału

% Dopasowanie długości sygnałów do porównania
yd = inst_freq - fc; % przesunięcie częstotliwości

% Wyświetlanie wyników
t = t(1:length(yd)); % dopasowanie długości czasu do zdemodulowanego sygnału
figure;
subplot(211); plot(t, yd); grid; xlabel('t (s)'); title('y_{demod}(t) - Demodulated Signal');
subplot(212); spectrogram(yd, 256, 192, 512, fs, 'yaxis'); title('STFT(3) - Spectrogram of Demodulated Signal'); pause

% Konwersja z powrotem do oryginalnej częstotliwości próbkowania
xd = resample(yd, 1, K);

% Odtwarzanie zdemodulowanego sygnału
soundsc(xd, fx);
pause
