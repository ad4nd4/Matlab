speed = 30;
x0 = 50; y0 = 10;
xk = 50; yk = 300;

co = 0.8;
P = 5;
f = 3 * 10^9;
c = 3 * 10^8;
lambda = c / f;

xBS = 110; yBS = 190;    % S - nadajnik
xBS1 = 110; yBS1 = 270; % S'1 (odbicie nadajnika w scianie 1)
xBS2 = 50; yBS2 = 190;  % S'2 (odbicie nadajnika w scianie 2)

Pr = [];
idx = 1;

for t = 0.010:0.010:6
    s = speed * t;
    xCar = x0;
    yCar = s + y0;

    res1 = dwawektory(xBS, yBS, xCar, yCar, 90, 100, 220, 100);   %  1 => przecina (jest odbicie)
    res2 = dwawektory(xBS1, yBS1, xCar, yCar, 90, 100, 220, 100); % -1 => nie przecina
    res3 = dwawektory(xBS2, yBS2, xCar, yCar, 50, 10, 50, 300);

    H1 = 0; H2 = 0; H3 = 0;

    if res1 == -1 % przypadek 1: promien nie przecina sciany
        dist = sqrt((xCar-xBS)^2 + (yCar-yBS)^2);
        H1 = 1 * (lambda/(4*pi*dist)) * exp(-1i*2*pi*dist/lambda);
    end
    if res2 == 1 % przypadek 2: promien przecina przecina sciane
        dist = sqrt((xCar-xBS1)^2 + (yCar-yBS1)^2);
        H2 = 0.8 * (lambda/(4*pi*dist)) * exp(-1i*2*pi*dist/lambda);
    end
    if res3 == 1
        dist = sqrt((xCar-xBS2)^2 + (yCar-yBS2)^2);
        H3 = 0.8 * (lambda/(4*pi*dist)) * exp(-1i*2*pi*dist/lambda);
    end

    H = H1 + H2 + H3; % transmitancja
    if H == 0
        Pr(idx) = -100;
    else
        Pr(idx) = 10*log10(P) + 20*log10(abs(H)); % moc sygnalu
    end

    idx = idx + 1;

end

plot(Pr);