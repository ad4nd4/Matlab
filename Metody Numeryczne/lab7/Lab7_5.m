clear all; close all;

K = 28; % Nowa liczba
w = 0 : pi/100 : pi;

d1 = 1/12 * [-1 8 0 -8 1];
d2 = firls(K-1, [0 0.5 0.7 1], [0 0.5*pi 0 0], 'differentiator');
d3 = firpm(K-1, [0 0.5 0.7 1], [0 0.5*pi 0 0], 'differentiator');

figure;
plot(w/pi, abs(freqz(d1, 1, w))/pi, 'b-', ...
     w/pi, abs(freqz(d2, 1, w))/pi, 'r--', ...
     w/pi, abs(freqz(d3, 1, w))/pi, 'm-.');
xlabel('f/fnorm'); title('|D(fnorm)|'); grid;
legend('DIFF', 'LS', 'MIN-MAX');

% Zastosowanie wag filtrów do sygnału sinusoidalnego
f = 0.1; 
t = 0:0.01:1;
x = sin(2*pi*f*t);

y1 = filter(d1, 1, x); % filtracja różniczkująca skończona
y2 = filter(d2, 1, x); % filtracja za pomocą firls
y3 = filter(d3, 1, x); % filtracja za pomocą firpm

figure;
%subplot(3,1,1); plot(t, x, 'b-', t, y1, 'r--'); title('Filtracja DIFF');
%subplot(3,1,2); plot(t, x, 'b-', t, y2, 'r--'); title('Filtracja LS');
%subplot(3,1,3); plot(t, x, 'b-', t, y3, 'r--'); title('Filtracja MIN-MAX');
