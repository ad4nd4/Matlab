clear all; close all;

fpr = 10000; dt = 1/fpr;
f = [ 1000  2000  3000 ];
d = [ 1     2     3    ];
A = [ 1   0.5    0.25  ];
K = length(f);
P = 2*K;
N = 2*P;
x = zeros(1,N);
for k = 1:K
    x = x + A(k)*exp(-d(k)*(0:N-1)*dt) .* cos(2*pi*f(k)*(0:N-1)*dt + pi*rand(1,1));
end

X = toeplitz(x(P:2*P-1), x(P:-1:1)),
x = x(P+1 : P+P)',
a = inv(X)*x;
r = roots([1, -a']);
pow = log(r);
omega = imag(pow);
[omega, indx] = sort(omega,'ascend');
fest = omega(K+1:2*K)/(2*pi*dt),
dest = -real(pow(indx(K+1:2*K)))/dt,

% Tworzenie macierzy E
E = zeros(N, 2 * K);
for k = 1:K
    E(:, 2 * k - 1) = exp(-d(k) * (0:N-1) * dt) .* cos(2 * pi * f(k) * (0:N-1) * dt);
    E(:, 2 * k) = exp(-d(k) * (0:N-1) * dt) .* sin(2 * pi * f(k) * (0:N-1) * dt);
end

% Obliczenie c za pomocą równania macierzowego Ec = x
c = E / x';

% Rozdzielenie wartości amplitud i kątów tłumionych z wektora c
amp = abs(c(1:2:end));  % Wartości amplitud
dam_ang = -angle(c(2:2:end)) / dt;  % Kąty tłumione

% Wyświetlenie wyników
disp('Wartości amplitud:');
disp(amp);
disp('Kąty tłumione:');
disp(dam_ang);