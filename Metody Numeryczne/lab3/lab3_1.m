clear all; close all;

u = [1;2;3];

v = [4;5;6];

A = [1,2,3;
     4,5,6;
     7,8,9];

B = eye(3);

disp("1.Mnozenie wektorow (najpierw trzeba transponowac poprzez .') u*v = "), disp((u.') *v);
disp("2.Dodawanie macierzy A + B = "), disp(A + B);
disp("3.Mnozenie macierzy A * B = "), disp(A * B);
disp("4.Mnozenie transponowanej u oraz A: "), disp((u.')*A);
disp("5.Mnozenie A*u = "), disp(A*u);
disp("6.Mnozenie stałej 10 * macierz A: "), disp(10*A);
disp("7.Sprawdzenie (A+B)u = Au + Bu"),
if (A+B)*u == A*u + B*u
    disp("tak")
else
    disp("nie")
end
disp("8.Obliczanie macierzy odwroconej od B (B^-1): "), disp(inv(B))
disp("9.Obliczanie wyznacznika macierzy: "), disp(det(A));