close all;
clear all;

% dane
fpr=1200;           %czestotliwosc probkowania
df=200;             %szerokosc pasma przepustowego
fc=300;             %srodek pasma przepustowego
N=128;              %długość filtru
fup=fc+(df/2);      %gorna granica filtru
fdown=fc-(df/2);    %dolna granica filtru

% okno hamminga
figure(1);
hold all;
b1 = fir1(N,[fdown/fpr*2 fup/fpr*2],hamming(N+1));
[h1,f1] = freqz(b1,1,N,fpr); %odpowiedz impulsowa
plot(f1,20*log10(abs(h1)));


% okno hanninga
b2 = fir1(N,[fdown/fpr*2 fup/fpr*2],hanning(N+1));
[h2,f2] = freqz(b2,1,N,fpr);
plot(f2,20*log10(abs(h2)));