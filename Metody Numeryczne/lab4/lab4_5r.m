clear all;
close all;

A = [1,2; 3,4];
B = [3,3,3; 4,5,6; 7,4,9];

[U] = odwrotnosc_rzedu_3(B);
[V] = odwrotnosc_rzedu_2(A);
[T] = odwrotnosc_rzedu_2(V);

disp('Macierz odwrotna rzedu 3:');
disp(U);

disp('Macierz odwrotna rzedu 2:');
disp(V);

disp('Macierz odwrotna rzedu 2 z macierzy odwrotnej rzedu 2:');
disp(T);

[U_rek] = odwrotnosc_rekurencyjna(B);
disp('Macierz odwrotna rekurencyjna:');
disp(U_rek);

function [U] = odwrotnosc_rzedu_2(A)
    if det(A) == 0
        U = 0;
        disp("Wyznacznik różny od zera!");
    else
        U = 1/(A(1,1)*A(2,2) - A(2,1)*A(1,2)) * [A(2,2) -A(1,2); -A(2,1) A(1,1)];
    end
end

function [U] = odwrotnosc_rzedu_3(B)
    if det(B) == 0
        U = 0;
        disp("Wyznacznik różny od zera!");
    else
        N = size(B);
        T = zeros(N(1), N(1)); 

        for i = 1:N(1)
            for j = 1:N(1)
                matrix_dop = B;
                matrix_dop(i, :) = [];
                matrix_dop(:, j) = [];

                T(i, j) = (-1)^(i+j) * det(matrix_dop);
            end
        end

        U = 1/(det(B)) * T.';
    end    
end

function [U] = odwrotnosc_rekurencyjna(B)
    [n, ~] = size(B);
    U = zeros(n, n);
    
    if det(B) == 0
        U = 0;
        disp("Wyznacznik różny od zera!");
    else
        U = rekurencja(B, U, n);
    end
end

function [U] = rekurencja(B, U, k)
    if k == 1
        % Przypadek bazowy: jednoelementowa macierz
        U(1, 1) = 1 / B(1, 1);
    else
        % Obliczenia rekurencyjne
        U = rekurencja(B, U, k - 1);
        S = B(k, 1:k-1) * U(1:k-1, 1:k-1);
        U(k, 1:k-1) = -S / B(k, k);
        U(k, k) = 1 / B(k, k) + S / B(k, k) * U(1:k-1, k);
    end
end

