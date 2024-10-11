clear all; close all;

fs = 1000; %samp
fpilot = 19000; %pilot
N = fs * 10;
t = (0:N-1) / fs; % wektor czasu

%pilot
phi = pi/4;
pilot = cos(2*pi*fpilot*t + phi);

df = 10; % zmiana częstotliwości
fm = 0.1; % częstotliwość modulacji
pilot_mod = cos(2*pi*(fpilot + df*sin(2*pi*fm*t)).*t + phi);


theta = zeros(1, N+1);
alpha = 1e-2;
beta = alpha^2/4;
freq = 2*pi*fpilot/fs;
for n = 1:N
    perr = -pilot(n)*sin(theta(n));
    theta(n+1) = theta(n) + freq + alpha*perr;
    freq = freq + beta*perr;
end
c57 = cos(3*theta(1:end)); % nosna 57 kHz

snr_values = [0, 5, 10, 20]; % wartości SNR w dB
convergence_time = zeros(size(snr_values));
figure;
for i = 1:length(snr_values)
    noisy_signal = awgn(pilot, snr_values(i), 'measured'); % dodanie szumu
    theta_noisy = zeros(1, N+1);
    freq_noisy = 2*pi*fpilot/fs;
    for n = 1:N
        perr = -noisy_signal(n)*sin(theta_noisy(n));
        theta_noisy(n+1) = theta_noisy(n) + freq_noisy + alpha*perr;
        freq_noisy = freq_noisy + beta*perr;

        if abs(theta_noisy(n+1) - theta(n+1)) < 1e-3
            convergence_time(i) = n;
            break;
        end
    end
    subplot(2,2,i);
    plot(t, pilot, t, cos(theta_noisy(1:end-1)));
    title(['Sygnał z szumem SNR = ' num2str(snr_values(i)) ' dB']);
    legend('Oczekiwany sygnał', 'PLL Output');
    xlabel('Czas [s]');
    ylabel('Amplituda');
end

% Wykresy
figure;
plot(t, pilot, t, cos(theta(1:end-1)));
title('Sygnał pilot bez szumu i odpowiedź PLL');
legend('Oczekiwany sygnał', 'PLL Output');
xlabel('Czas [s]');
ylabel('Amplituda');

figure;
plot(t, pilot_mod);
title('Sygnał pilot z modulacją częstotliwości');
xlabel('Czas [s]');
ylabel('Amplituda');

%disp('Czasy zbieżności dla różnych SNR:');
%disp(array2table(convergence_time,"VariableNames",{'Convergence_Time'}));
convergence_time
