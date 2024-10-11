clear all; close all; clc;

N = 20;
A = randn(N);

%norma
normCheck = all(abs(arrayfun(@(i) norm(A(i,:)), 1:N) - 1) < 1e-10);

%ortog
orthogonalCheck = true;
for i = 1:N
    for j = i+1:N
        if abs(dot(A(i,:), A(j,:))) > 1e-10
            orthogonalCheck = false;
            break;
        end
    end
    if ~orthogonalCheck
        break;
    end
end

%ortonormalności
Orthonormal = normCheck && orthogonalCheck;
disp('Czy wiersze macierzy A są ortonormalne:');
disp(Orthonormal);

% Odwrotna
S = inv(A);

% AS == I?
IdentityCheck = round(A*S, 15);
disp('Czy AS == I:');
disp(IdentityCheck == eye(N));

x = randn(N, 1);
%analiza
y = A*x;
%synteza
xs = S*y;

% xs == x?
disp('Czy xs == x po transformacji z losową A:');
disp(norm(xs - x) < 1e-10);
