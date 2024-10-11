Pt_mW = 854; % Moc wyjściowa nadajnika w mW
G_dBi = 12; % Zysk energetyczny anteny w dBi
L_unit = 47; % Tłumienność jednostkowa linii w dB/100m
d_m = 8; % Długość linii w metrach

% Przeliczenie mocy nadajnika na dBm
Pt_dBm = 10 * log10(Pt_mW);

% Obliczenie strat na linii
L_dB = L_unit * d_m / 100;

% Obliczenie EIRP
EIRP_dBm = Pt_dBm + G_dBi - L_dB;
EIRP_dBW = EIRP_dBm - 30;
% Wyświetlenie wyniku
disp(['EIRP = ', num2str(EIRP_dBW), ' dBW'])
