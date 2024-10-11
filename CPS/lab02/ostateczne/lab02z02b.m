clear all; close all;
%macierz A w tym przypadku jest losowa i S jest jej odwrotnoscia
%liczenie macierzy odwrotnej to 1/wyzn * zmieniona macierz () trudne
%zadanie, wiec uzylam funkcji (d, -b, -c, a)
N = 20;
A = randn(N, N);

%orton.
orthonormal = true;
for l = 1:N
    if abs(norm(A(l, :)) - 1) > 1e-10
        orthonormal = false;
        break;
    end
end

if orthonormal
    disp('Wiersze macierzy A są ortonormalne.');
else
    disp('Wiersze macierzy A nie są ortonormalne.');
end

%macierz S teraz jest odwrotna do A
S = inv(A);

%AS == I?
I = A * S;

figure;
imagesc(I);
title('Wizualizacja I = SA');
colorbar; colormap('jet'); axis square;

xlabel('Indeks kolumny'); ylabel('Indeks wiersza');

%macierz identycznosciowa to eye (jedynki na przekatnej)
if all(all(abs(I - eye(N)) < 1e-10))
    disp('Macierz I = SA jest bardzo bliska macierzy identycznościowej.');
else
    disp('Macierz I = SA nie jest bliska macierzy identycznościowej.');
end

x = randn(N, 1);

%analiza
X = A * x;

%synteza
xs = S * X;

if all(abs(xs - x) < 1e-10)
    disp('Transformacja posiada właściwość perfekcyjnej rekonstrukcji.');
else
    disp('Transformacja nie posiada właściwości perfekcyjnej rekonstrukcji.');
end
