
% Filtry cyfrowe FIR (jedna suma) - SPECJALNE: HILBERTA, RÓŻNICZKUJĄCY
% b = ? [b0, b1, b2, ...]
% h = ? [h0, h1, h2, ...]

clear all; close all;

fpr = 8000;             % 8000, 44100, 48000, ...
dt = 1/fpr;

% Metoda okien - filtr Hilberta i różniczkujący
  K = 100; M = 2*K+1;
  n = -K : K;
  hH = (1-cos(pi*n))./(pi*n); hH(K+1)=0;   % Hilberta
  hD = cos(pi*n)./n;          hD(K+1)=0;   % różniczkujący
  h = hH;
  w = chebwin( M, 100 ).';
  h = h .* w;
  
% h = fliplr(h);

% Wagi filtra h(n)=b(n)
figure
stem(n,h); grid; xlabel('n'); title('h(n)=b(n)'); pause

% Ch-ka częstotliwościowa
f = 0 : 10 : fpr/2;
z = exp(j*2*pi*f/fpr);
H = polyval( h, z );

figure
subplot(211); plot(f,20*log10(abs(H))); xlabel('f [Hz]'); grid; title('|H(f)| [dB]');
subplot(212); plot(f,angle(H.*(exp(-j*2*pi*(K*dt)*f)))); xlabel('f [Hz]'); grid; title('faza H(f) [rad]');pause
%subplot(212); plot(f,angle(H)); xlabel('f [Hz]'); grid; title('faza H(f) [rad]');pause

% Sygnał
Nx = 2^10;
dt = 1/fpr;
t = dt*(0:Nx-1);
x = cos(2*pi*100*t);

% Filtracja
Nh = length(h);
bx = zeros(1,Nh);
for n = 1 : Nx
    bx = [ x(n), bx(1:Nh-1)];
    y(n) = sum( bx .* h );
end

% Synchronizacja
x = x( K+1 : end-K);
y = y( 2*K+1 : end);
t = t( K+1 : end-K);

% Wynik "filtracji"/"modyfikacji"

figure;
plot(t,x,'r-',t,y,'b-'); grid; title('RED x(t), BLUE y(t)' ); pause
