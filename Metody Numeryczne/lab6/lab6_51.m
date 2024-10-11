close all;
clear all;

% Generacja/wczytanie obrazka
N = 512; Nstep = 32;
[img, cmap] = imread('Lena512.bmp'); img = double(img); % Lena

% Dodawanie zniekształceń beczkowych
a = [1.06, -0.0002, 0.000005]; % współczynniki wielomianu zniekształceń
x = 1:N; y = 1:N;
cx = N / 2 + 0.5;
cy = N / 2 + 0.5;
[X, Y] = meshgrid(x, y); % wszystkie x,y
r = sqrt((X - cx).^2 + (Y - cy).^2); % wszystkie odległości od środka
R = a(1) * r.^1 + a(2) * r.^2 + a(3) * r.^3; % zmiana odległości od środka
Rn = R ./ r; % normowanie
imgR = interp2(img, (X - cx) .* Rn + cx, (Y - cy) .* Rn + cy); % interpolacja

% Estymacja zniekształceń beczkowych
i = Nstep : Nstep : N - Nstep;
j = i; % polozenie linii w pionie i poziomie
[I, J] = meshgrid(i, j); % wszystkie (x,y) punktów przecięć
r = sqrt((I - cx).^2 + (J - cy).^2); % wszystkie promienie od srodka
R = a(1) * r + a(2) * r.^2 + a(3) * r.^3; % odpowiadajace punkty obrazu znieksztalconego
r = sort(r(:)); % sortowanie
R = sort(R(:)); % sortowanie
aest1 = pinv([r.^1, r.^2, r.^3]) * R; aest1 = [aest1(end:-1:1); 0]; % rozw.1
aest2 = polyfit(r, R, 3)'; % rozw.2
[~, idx] = min(abs(diff(aest1)));
aest1 = aest1(1:idx); % skrócenie do pierwiastków
[~, idx] = min(abs(diff(aest2)));
aest2 = aest2(1:idx); % skrócenie do pierwiastków
[ aest1, aest2 ], % porownanie
aest = aest1; % wybor rozwiazania

% Znalezienie pierwiastków wielomianu
roots1 = roots(aest1);
roots2 = roots(aest2);

% Wizualizacja punktów przecięcia
figure;
subplot(1, 2, 1), imshow(img, cmap); title('Oryginal');
hold on;
plot(roots1, roots1, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
subplot(1, 2, 2), imshow(imgR, cmap); title('Rybie oko');
hold on;
plot(roots2, roots2, 'ro', 'MarkerSize', 10, 'LineWidth', 2);

% Korekta zniekształceń beczkowych
[X, Y] = meshgrid(x, y); % wszystkie punkty (x,y) znieksztalconego
R = sqrt((X - cx).^2 + (Y - cy).^2); % wszystkie zle promienie
Rr = polyval(aest, R); % wszystkie dobre promienie
Rn = Rr ./ R; % normowanie
imgRR = interp2(imgR, (X - cx) .* Rn + cx, (Y - cy) .* Rn + cy); % interpolacja

% Wizualizacja korekty
figure;
subplot(1, 2, 1), imshow(imgR, cmap); title('Wejscie - efekt rybie oko');
subplot(1, 2, 2), imshow(imgRR, cmap); title('Wyjscie - po korekcie');
colormap gray;
