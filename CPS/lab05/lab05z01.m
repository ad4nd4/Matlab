close all;
clear all;

% Bieguny transmitancji - wzmocnienia
p(1) = -0.5 + 9.5j;
p(2) = -0.5 - 9.5j;
p(3) = -1 + 10j;
p(4) = -1 - 10j;
p(5) = -0.5 + 10.5j;
p(6) = -0.5 - 10.5j;

% Zera transmitancji - zerowanie i tłumienie w pobliżu
z(1) = 5j;
z(2) = -5j;
z(3) = 15j;
z(4) = -15j;

%Transformacja
M = length(z);
N = length(p);

w = 0:0.1:20; % oś x - pulsacja

bm = 1;
for k=1:M
    bm = bm .* (1i*w - z(k));
end

an = 1;
for l = 1:N
    an = an .* (1i*w - p(l));
end


% zera i bieguny na płaszczyźnie zespolonej
figure(1);
plot(real(z),imag(z),'or',real(p),imag(p),'*b');
legend('Zera','Bieguny');
xlabel('Real');
ylabel('Imag');
grid;
title('Zera i bieguny');

% ch. a-cz
H = abs(bm./an);
figure(2);
subplot(2,2,1);
plot(w,H);
title('|H(j\omega)|');

subplot(2,2,2);
Hlog = 20*log10(H);
plot(w,Hlog);
%semilogy(w,H);
title('20*log_{10}|H(j\omega)|');


hmax = max(H);
H2 = H./hmax;
Hlog2 = 20*log10(H2);

subplot(2,2,3);
plot(w,H2);
title('|H(j\omega)| poprawione');

subplot(2,2,4);
plot(w,Hlog2);
title('20*log_{10}|H(j\omega)| poprawione');

% ch. f-cz
figure(3);
H3 = bm./an;
Hphase = atan(imag(H3)./real(H3));
plot(w, Hphase) 
title('Charakterystyka fazowo-częstotliwościowa');
xlabel('Częstotliwośc znormalizowana');
ylabel('Faza (radiany)');
% figure(3);
% H3 = bm./an; % Liczba zespolona H3
% Hphase = unwrap(angle(H3)); % Wyznaczenie fazy z unwrappingiem
% plot(w, Hphase) 
% title('Charakterystyka fazowo-częstotliwościowa');
% xlabel('Częstotliwość [\omega]');
% ylabel('Faza [radiany]');
% grid on;

figure(4);
plot(phasez(H));
%angle(H3);