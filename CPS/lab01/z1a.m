clear all; close all;

A = 230; %V
f = 50; %Hz
T = 1/f;

time = 0.1;

f1 = 10^4;
f2 = 500;
f3 = 200;
t1 = 0:1/f1:time;
t2 = 0:1/f2:time;
t3 = 0:1/f3:time;
s1 = A*sin(2*pi*f*t1);
s2 = A*sin(2*pi*f*t2);
s3 = A*sin(2*pi*f*t3);

plot(t1, s1, 'b-');
hold on;
plot(t2, s2, 'ro-');
plot(t3, s3, 'kx-');
hold off; %end

xlabel('Czas [s]'); 
ylabel('Amplituda [V]');
title('Sinusoida o różnych częstotliwościach próbkowania');
legend('fs = 10 kHz', 'fs = 500 Hz', 'fs = 200 Hz');