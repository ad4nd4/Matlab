% Wczytanie sygnału EKG
clear all; close all;
load ECG100.mat; % Zakładam, że sygnał znajduje się pod zmienną 'val'
ecg_signal = val(:);
fs = 180; % Częstotliwość próbkowania

% Obliczanie i wyświetlanie widma częstotliwościowego za pomocą pwelch
[pxx, f] = pwelch(ecg_signal, [], [], [], fs);
figure;
plot(f, 10*log10(pxx));
title('Widmo częstotliwościowe sygnału EKG');
xlabel('Częstotliwość (Hz)');
ylabel('Gęstość widmowa mocy (dB/Hz)');
grid on;

% Projektowanie filtra FIR z inną częstotliwością odcięcia
low_cutoff = 0.5; % Dolna częstotliwość odcięcia (Hz)
high_cutoff = 40; % Górna częstotliwość odcięcia (Hz)
nyquist = fs / 2;
filter_order = 100;
b = fir1(filter_order, [low_cutoff high_cutoff] / nyquist);

% Lista poziomów szumu do przetestowania
noise_levels = [0.1, 0.5];

% Inicjalizacja figure dla subplots
figure;
num_plots = length(noise_levels);

for i = 1:num_plots
    noise_amplitude = noise_levels(i);

    % Dodanie szumu gaussowskiego
    noisy_ecg_signal = ecg_signal + noise_amplitude * randn(size(ecg_signal));

    % Filtrowanie zaszumionego sygnału EKG
    filtered_ecg_signal = filtfilt(b, 1, noisy_ecg_signal);

    % Kompensacja opóźnienia filtra
    P = floor((filter_order - 1) / 2); % Zaokrąglij w dół, aby uzyskać całkowitą wartość
    compensated_filtered_signal = filtered_ecg_signal(P+1:end-P);

    % Dopasowanie długości sygnałów do porównania
    original_signal = ecg_signal(P+1:end-P);
    noisy_signal = noisy_ecg_signal(P+1:end-P);
    filtered_signal = compensated_filtered_signal;

    % Obliczenie błędów
    mse_noisy = mean((original_signal - noisy_signal).^2);
    mse_filtered = mean((original_signal - filtered_signal).^2);

    % Wyświetlenie wyników na subplots
    subplot(num_plots, 3, (i-1)*3 + 1);
    plot(original_signal);
    title(['Oryginalny sygnał EKG (Szum = ' num2str(noise_amplitude) ')']);
    xlabel('Próbka');
    ylabel('Amplituda');

    subplot(num_plots, 3, (i-1)*3 + 2);
    plot(noisy_signal);
    title(['Zaszumiony sygnał EKG (MSE = ' num2str(mse_noisy) ')']);
    xlabel('Próbka');
    ylabel('Amplituda');

    subplot(num_plots, 3, (i-1)*3 + 3);
    plot(filtered_signal);
    title(['Odfiltrowany sygnał EKG (MSE = ' num2str(mse_filtered) ')']);
    xlabel('Próbka');
    ylabel('Amplituda');
end

% Wyświetlenie porównania oryginalnego i odfiltrowanego sygnału dla różnych poziomów szumu
figure;
for i = 1:num_plots
    noise_amplitude = noise_levels(i);

    % Dodanie szumu gaussowskiego
    noisy_ecg_signal = ecg_signal + noise_amplitude * randn(size(ecg_signal));

    % Filtrowanie zaszumionego sygnału EKG
    filtered_ecg_signal = filtfilt(b, 1, noisy_ecg_signal);

    % Kompensacja opóźnienia filtra
    P = floor((filter_order - 1) / 2); % Zaokrąglij w dół, aby uzyskać całkowitą wartość
    compensated_filtered_signal = filtered_ecg_signal(P+1:end-P);

    % Dopasowanie długości sygnałów do porównania
    original_signal = ecg_signal(P+1:end-P);
    filtered_signal = compensated_filtered_signal;

    % Wyświetlenie porównania oryginalnego i odfiltrowanego sygnału
    subplot(num_plots, 1, i);
    plot(original_signal);
    hold on;
    plot(filtered_signal);
    title(['Porównanie oryginalnego i odfiltrowanego sygnału EKG (Szum = ' num2str(noise_amplitude) ')']);
    xlabel('Próbka');
    ylabel('Amplituda');
    legend('Oryginalny sygnał', 'Odfiltrowany sygnał');
    hold off;
end
