close all; clear all;

% program ma przybliżać matlabową funkcję erf(x)
x = -1 : 0.1 : 1;
y = erf(x);
plot(x,y,'k--');
hold on;

Czybyszew(@(x)erf(x),8)

% liczenie calki
%syms x t
% wyrażenie podcałkowe
%wyrazenie = exp(-t.^2);

% przedział x:
%x2 = -1 : 0.1 : 1;

% okreslenie jak wyglada cała funkcja
%y2 = (2 / sqrt(pi)) * int(wyrazenie,[0,x]);
%fplot(y2,'b'); % wyswietlanies funkcji

% teraz przybliżanie metodą z poprzedniego zadania
%Czybyszew((2 / sqrt(pi)) * int(wyrazenie,[0,x]), 8);