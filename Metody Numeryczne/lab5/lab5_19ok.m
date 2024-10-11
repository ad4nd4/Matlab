clear all; close all;

% sinusoida - generowanie
T = 50*pi;
x_0 = linspace(0, T, 100);
y_0 = sin(x_0);

% zmniejszanie rozdzielczości
samples = 100;
x_t = 0;
for i = pi/2 : pi/2 : T-pi/2
    x_t = [x_t, i];
end
y_t = sin(x_t);

% interpolacja z zmniejszonej
x_p = [];

% pi/16 to jeden krok dla 32 próbek per 2pi
for i = 0: pi/16 : T
    x_p=[x_p, i];
end

% T to czas pomiędzy próbkami, n to numer próbki
% nT to czas próbki n, czyli x_t
% t to zaś czas dla którego obliczamy funkcję
% pi/T to częstotliwość

y_p=[];
for t=x_p
    sum = 0;
    for i=1:length(y_t)
        xnT = y_t(i);
        nT = x_t(i);
        sum = sum + xnT * (sin( (pi/T)*(t-nT) ) / ((pi/T) * (t -nT)));
    end
    y_p = [y_p, sum];
end

plot(x_0, y_0, '-y'); hold on; plot(x_t, y_t, 'ob'); plot(x_p, y_p, '-og');