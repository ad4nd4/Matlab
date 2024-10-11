clear all; close all;
%Współczynniki DCT dają wgląd w składowe częstotliwościowe sygnału, umożliwiając efektywne 
% jego przetwarzanie i analizę, a także kompresję bez znaczącej utraty jakości percepcyjnej.
%ortogonalna jest macierz eye!!!
%rozmiar macierzy to 20, więc to git, potem robie sobie tą macierz wg wzoru
%wybralam iloczyn skalarny, ale sprawdzilam inne i jest git
%wartosci sa bardzo bliskie 0 i mieszczą sie w granicy bledu(zmiennoprzec), wiec zeby nie
%przeklamywac to tutaj nie mam jeszcze jakichs przyblizen.
N = 20;
A = zeros(N, N);

%Macierz A
for k = 0:N-1
    for n = 0:N-1
        if k == 0
            sk = 1 / sqrt(N); %cos0
        else
            sk = sqrt(2 / N);
        end
        A(k+1, n+1) = sk * cos(pi * k / N * (n + 0.5));
    end
end

%orton.
ortonormal = true;
for l = 1:N
    for m = l+1:N %nie chce miec tych z przekatnej, bo to eye
        iloczyn_skalarny = sum(A(l, :) .* A(m, :));
        fprintf('Iloczyn skalarny wierszy %d i %d wynosi: %g\n', l, m, iloczyn_skalarny);
        if abs(iloczyn_skalarny) > 1e-10 %prog bledu
            ortonormal = false;
            fprintf('Wiersze %d i %d nie są ortonormalne.\n', l, m);
        end
    end
end

if ortonormal
    disp('Wszystkie wiersze macierzy A są do siebie ortonormalne.');
else
    disp('Nie wszystkie wiersze macierzy A są do siebie ortonormalne.');
end
