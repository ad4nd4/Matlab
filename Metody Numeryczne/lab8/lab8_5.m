clear all;
close all;

% wymiary
N = 4;
if (1)
    A = randn(N, N); % losowa macierz o rozmiarze NxN
else
    A = magic(N);
end

%wyznaczniki bliskie zeru (takie sprytne, ze osatnia to 1)
A(:, N) = A(:, 1);

% Wyświetlenie oryginalnej macierzy
disp('Oryginalna macierz A:');
disp(A);

% iteracyjna dekompozycja QR
x = ones(N, 1);
[Q, R] = qr(A);

for i = 1:30 % petla - start
    [Q, R] = qr(R * Q); % kolejne iteracje
end % petla - stop

A1 = R * Q; % ostatni wynik
lambda = diag(A1); % elementy na przekątnej
ref = eig(A); % porównanie z Matlabem

% Wyświetlanie wyników
disp('Ostatnia macierz A1:');
disp(A1);
disp('Wartości własne obliczone przez program:');
disp(lambda);
disp('Wartości własne uzyskane za pomocą funkcji eig:');
disp(ref);
