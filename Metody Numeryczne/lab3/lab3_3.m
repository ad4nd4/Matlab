clear all; close all;
Ze = 3;
Zs1 = 1;
Zs2 = 2;
Zd = 5;
Zo = 4;

E = 2;

A = [1/Ze + 1/Zs1,       -1/Zs1        ,        0       ;
        -1/Zs1   , 1/Zs1 + 1/Zs2 + 1/Zd,     -1/Zs2     ;
         0       ,       -1/Zs2        , 1/Zs2 + 1/Zo],
b = [E/Ze;
       0 ;  
       0 ],

x1 = inv(A)*b;
x2 = pinv(A)*b;
x3 = A\b;

for k=1:length(b)
    Ak = A;
    Ak(:,k) = b;
    x4(k) = det(Ak)/det(A);
end
x4 = x4.';
[x1, x2, x3, x4], pause