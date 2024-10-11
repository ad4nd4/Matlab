v = 30;
x0 = 50; y0 = 10;
xk = 50; yk = 300;

co = 0.8;
P = 5;
f = 3 * 10^9;
c = 3 * 10^8;
lambda = c / f;


Pr = zeros(1, 601); % Prealokacja Pr dla wydajności
idx = 1;

for t = 0.01:0.01:6
    s = v * t;
    yCar = s + y0;

    H1 = 0; H2 = 0; H3 = 0;

    if yCar >= 100 && yCar <= 220 % Sprawdzenie, czy samochód jest w obszarze przecięcia ściany 1
        r1 = sqrt((x0 - xBS1)^2 + (yCar - yBS1)^2);
        H2 = co * (lambda / (4 * pi * r1)) * exp(-1i * 2 * pi * r1 / lambda);
    end

    if yCar >= 10 && yCar <= 300 % Sprawdzenie, czy samochód jest w obszarze przecięcia ściany 2
        r2 = sqrt((x0 - xBS2)^2 + (yCar - yBS2)^2);
        H3 = co * (lambda / (4 * pi * r2)) * exp(-1i * 2 * pi * r2 / lambda);
    end

    if H2 == 0 % Jeśli brak odbicia, oblicz transmitancję dla pierwszego przypadku
        r0 = sqrt((x0 - xBS)^2 + (yCar - yBS)^2);
        H1 = (lambda / (4 * pi * r0)) * exp(-1i * 2 * pi * r0 / lambda);
    end

    H = H1 + H2 + H3; % Transmitancja
    if H == 0
        Pr(idx) = -100;
    else
        Pr(idx) = 10 * log10(P) + 20 * log10(abs(H)); % Moc sygnału
    end

    idx = idx + 1;
end

plot(Pr);
