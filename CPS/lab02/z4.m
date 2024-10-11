clear all; close all;
clc;

N = 256;
[x, fs] = audioread('mowa.wav');
probki = [68, 1022, 3856, 9052, 10275, 12400, 16505, 19305, 23615, 31000];
M = length(probki);

figure(2)
plot(x);

% generowanie wzorca cosinusowego I wiersz
A = zeros(N);

for k = 0:N-1
    for n = 0:N-1
        if k == 0
            sk = sqrt(1/N);
        else
            sk = sqrt(2/N);
        end
        A(k+1,n+1) = sk * cos(pi * k / N * (n + 0.5));
    end
end

for k=1:M
    xk(1:256,k) = x(probki(k):probki(k)+255);
    y(:,k) = A*xk(:,k);
end

f = (1:N)*fs/N;

for i=1:M
    plot(i)
    subplot(2,1,1)
    plot(f, xk(:,i), 'b-o');
    title(num2str(probki(i)))
    subplot(2,1,2)
    stem(f, abs(y(:,i)))
    ylim([0 1]);
    pause(0.5);
end