clear all; close all;

% macierze do testowania

%2x2
A = [1 2;
     3 4];

b = [5;
     11];

%3x3
A2 = [1, 2, 3;
      4, 5, 6;
      7, 8, 9];

b2 = [1;
      2; 
      3];


% przykladowe rozwiazanie
x1 = inv(A)*b; % x=A^(-1)*b
x2 = A\b; % optymalne rozwiazywanie rown. Ax=b

% rozwiazanie proste podpunktu 1
AdoMinus1 = (1 / (A(1,1)*A(2,2) - A(2,1)*A(1,2))) * [A(2,2) , -A(1,2);
                                                    -A(2,1) , A(1,1)];
x3 = A\b;

% rozwiązanie proste podpunktu 2 poprzez:
% stworzenie macierzy dopełnien algebraicznych
% działa dla kazdego rozmiaru macierzy
fun(A)