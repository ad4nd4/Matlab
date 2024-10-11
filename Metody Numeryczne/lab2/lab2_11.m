clear all; close all;

x = 10^(-50);
y = 10^200;
z = 10^300;

C1 = (x*y)/z;
C2 = x*(y/z);
C3 = (x/z)*y;            %to nie

disp("C1 ="), disp(C1)
disp("C2 ="), disp(C2)
disp("C3 ="), disp(C3)