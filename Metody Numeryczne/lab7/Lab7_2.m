close all; clear all;

% f sinus
x1=0;
x2=pi/2;
x3=pi/4;

syms x;
y=sin(x);

y1=sin(x1),
y2=sin(x2),
y3=sin(x3),

pochodna=cos(x);

%dokladne wartosci pochodnych z sinx
p1=cos(x1);
p2=cos(x2);
p3=cos(x3);

h=pi/4;
px1=(1/(2*h))*(-3*y1+4*y2-y3);
px2=(1/(2*h))*(y3-y1);
px3=(1/(2*h))*(y1-4*y2+3*y3);

err0=abs(px1-p1),
err1=abs(px2-p2),
err2=abs(px3-p3), % otrzymane blezy sa duże

%f wielomianowa
xx1=1;
xx2=2;
xx3=3;

yy=0.5+x+2*(x^2);
yy1=0.5+xx1+2*(xx1^2);
yy2=0.5+xx2+2*(xx2^2);
yy3=0.5+xx3+2*(xx3^2);

pochodnay_y=4*x+1; % pochodna z funkcji wielomianowej
pp1=4*xx1+1,
pp2=4*xx2+1,
pp3=4*xx3+1,% oblcizone wartosci z pochodnej funkcji

% obliczenie pochodnej na podstawie 3 wzorow
h1=1;
ppx1=(1/(2*h1))*(-3*yy1+4*yy2-yy3);
ppx2=(1/(2*h1))*(yy3-yy1);
ppx3=(1/(2*h1))*(yy1-4*yy2+3*yy3);

%obliczenie wartosci błędów
erx0=abs(ppx1-pp1);
erx1=abs(ppx2-pp2);
erx2=abs(ppx3-pp3); % błędy wynoszą 0

% wielomian  y = 0.5+x +2x^2+3x^3
wielomian=0.5+x+2*(x^2)+3*(x^3); %skorzystamy z wczesniejszego xx0,xx1,xx2
wartoscwielomianu1=0.5+xx1+2*(xx1^2)+3*(xx1^3);
wartoscwielomianu2=0.5+xx2+2*(xx2^2)+3*(xx2^3);
wartoscwielomianu3=0.5+xx3+2*(xx3^2)+3*(xx3^3);

pochodnawielomianu=9*(x^2)+4*x+1;

wartosczpochodnej1=9*(xx1^2)+4*xx1+1,
wartosczpochodnej2=9*(xx2^2)+4*xx2+1,
wartosczpochodnej3=9*(xx3^2)+4*xx3+1,

%obliczenie pochodnej na podstawie 3 wzorow
pw1=(1/(2*h1))*(-3*wartoscwielomianu1+4*wartoscwielomianu2-wartoscwielomianu3),
pw2=(1/(2*h1))*(wartoscwielomianu3-wartoscwielomianu1),
pw3=(1/(2*h1))*(wartoscwielomianu1-4*wartoscwielomianu2+3*wartoscwielomianu3),

ex1=abs(pw1-wartosczpochodnej1),
ex2=abs(pw2-wartosczpochodnej2),
ex3=abs(pw3-wartosczpochodnej3), %bledy mniejsze niz 10, duze