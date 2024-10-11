close all; clear all;

% Dane wejsciowe
[x,fpr]=audioread('elephant.wav',[1,2^14]);
[c,fps]=audioread('canary.wav',[1,2^14]);
x=x+c;
N = length(x);

figure; plot(x); title('x(n)');

% Transformacja liniowa/ortogonalna - ANALIZA
n = 0:N-1;
k = 0:N-1;
A = sqrt(2/N) * cos(pi/N * (k'*n));
y = A*x;
figure; plot(y); title('y(k)');

% Modyfikacja wyniku
y = cutFreq(y, 0.001, 5);
y = cutFreq(y, 10, 16.3);

figure; plot(y); title('y(k)');

% Transformacja odwrotna - SYNTEZA
xback = A'*y;
figure; plot(xback); title('xback(n)');

%audiowrite('input.wav',x,fpr);
%audiowrite('output.wav',xback,fpr);

soundsc(x,fpr); pause
soundsc(xback,fpr);