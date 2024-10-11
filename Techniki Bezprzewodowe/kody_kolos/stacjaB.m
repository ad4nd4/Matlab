% Dane wejściowe
B_ksps = 300; % Przepływność symbolowa w ksps
B_Hz = B_ksps * 1e3; % Przepływność symbolowa w Hz
T_s = 1 / B_Hz; % Odstęp między symbolami w sekundach
c_mps = 3e8; % Prędkość światła w m/s

% Częstotliwości nośne
fc_MHz = [868, 2400]; % Częstotliwości nośne w MHz
fc_Hz = fc_MHz * 1e6; % Częstotliwości nośne w Hz

% Obliczenie maksymalnej prędkości
v_mps = (c_mps) ./ (2 * fc_Hz * T_s); % Maksymalna prędkość w m/s
v_kph = v_mps * 3.6; % Maksymalna prędkość w km/h

% Wyświetlenie wyników
for i = 1:length(fc_MHz)
    disp(['Dla pasma ', num2str(fc_MHz(i)), ' MHz, maksymalna prędkość wynosi ', num2str(v_kph(i)), ' km/h'])
end
