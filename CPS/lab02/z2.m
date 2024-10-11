clear all;
clc;

N = 100;

%DCT
A = zeros(N);
for k = 1:N
    for n = 1:N
        if k == 1
            sk = sqrt(1/N);
        else
            sk = sqrt(2/N);
        end
        A(k,n) = sk * cos(pi * (2*(n-1) + 1) * (k-1) / (2 * N));
    end
end

S = A'; % Transpozycja macierzy A, bo to S (zupa)

% Sprawdzenie, czy SA == I
IdentityCheck = round(S*A, 15); %S*A; %zaokrąglenie (help)
disp('Czy SA == I:');
disp(IdentityCheck == eye(N)); % eye = macierz jednostkowa

% Wygenerowanie losowego sygnału x
x = randn(N, 1);

% Analiza
X = A * x;

% Rekonstrukcja
xs = S * X;

disp('Czy xs == x:');
disp(norm(xs - x) < 1e-10);