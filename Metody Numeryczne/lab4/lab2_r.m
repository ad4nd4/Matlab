clear all; close all;

A = [1,2;
     3,4];

[L, U] = myLU(A, 2),

[L, U] = chol(A),