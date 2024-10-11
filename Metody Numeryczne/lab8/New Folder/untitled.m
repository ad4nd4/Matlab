
% Parametry
X_dBm = -57;        % Średni poziom sygnału w dBm
N0_dBW_Hz = -204;   % Gęstość mocy szumu w dBW/Hz
bandwidth_Hz = 1e6; % Szerokość pasma kanału w hertach (1 MHz)

% Obliczanie efektywności widmowej
efficiency = calculate_spectral_efficiency(X_dBm, N0_dBW_Hz, bandwidth_Hz);
fprintf('Efektywność widmowa: %.2f bits/Hz\n', efficiency);
function spectral_efficiency = calculate_spectral_efficiency(X_dBm, N0_dBW_Hz, bandwidth_Hz)
    % Convert dB values to linear scale
    X_linear = 10^(X_dBm / 10);
    N0_linear = 10^(N0_dBW_Hz / 10); % Względem dBW/Hz

    % Obliczanie efektywności widmowej
    spectral_efficiency = log2(1 + X_linear / (N0_linear * bandwidth_Hz));
end
