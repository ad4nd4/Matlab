clear all; close all;

A = [2 0 0 1; 0 -2 0 0; 0 0 2 0; 1 0 0 3];

% to jest ta tala funkcja co sie sumowalo wartosci
[R, D, V] = solve(A);

% wyniki
disp('Macierz A:');
disp(A);
disp('Macierz R (macierz podobieństwa):');
disp(R);
disp('Macierz D:');
disp(D);
disp('Macierz V (wektory własne):');
disp(V);


[V_matlab, D_matlab] = eig(A);
R_matlab = V_matlab;


disp('Porównanie wyników z funkcją eig:');
disp('Macierz D z solve:');
disp(D);
disp('Macierz D z eig:');
disp(D_matlab);

disp('Macierz R z solve:');
disp(R);
disp('Macierz R z eig:');
disp(R_matlab);

disp('Macierz V z solve:');
disp(V);
disp('Macierz V z eig:');
disp(V_matlab);

% nie wiem czy to chce
%disp('Największe elementy poza główną przekątną:');
%disp(max(abs(R*D*inv(R) - A)));

function [R, D, V] = solve(A)
    D = A;
    [N, ~] = size(D);
    R = eye(N);
    
    while true
        Dabs = abs(D - tril(D));
        [v, x, y] = mmax(Dabs);
        assert(Dabs(y, x) == v);

        if abs(v) > 1e-11
            Ri = Rispawner(y, x, D);
            D = Ri' * D * Ri;
            R = R * Ri;
        else
            break;
        end
    end
    [V, D] = eig(A);
end

%tutaj sobie spisalam robienie wektorow i dokladniej mam rozpisane na
%kartce
function [v, x, y] = mmax(A)
    [~, N] = size(A);
    [v, i] = max(A(:));
    x = fix(i / N) + 1;
    y = rem(i, N);
end

%tutaj robi się R ze strasznych wzorów z wykładu
function [Ri] = Rispawner(p, q, A)
    xi = (A(q, q) - A(p, p)) / (2 * A(p, q));
%modul ;(
    if xi > -eps
        t = abs(xi) + sqrt(1 + xi^2);
    else
        t = -(abs(xi) + sqrt(1 + xi^2));
    end

    co = 1 / sqrt(1 + t^2);
    si = t * co;

    [N, ~] = size(A);
    Ri = eye(N);
    Ri(p, p) = co;
    Ri(q, q) = co;
    Ri(p, q) = -si;
    Ri(q, p) = si;
end
