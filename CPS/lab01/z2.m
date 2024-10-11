clear all; close all;

A = 230;
f = 50;
fs1 = 10000;
fs3 = 200;
t1 = 0:1/fs1:1;
t3 = 0:1/fs3:1-1/fs3;
x1 = A*sin(2*pi*f*t1);
x3 = A*sin(2*pi*f*t3);

fs = 10000;
t = 0:1/fs:1-1/fs;
sinc_fun = sinc((ones(length(t),1)*t3) - (t'*ones(1,length(t3))));
reconstructed_signal = x3(1:200)*sinc_fun';

figure(1);
plot(t1,x1,'b-'); hold on;
legend('pseudoanalog');

figure(2);
plot(t1,x1,'r-'); hold on;
plot(t,reconstructed_signal,'g-'); hold on;
legend('pseudoanalogowy', 'zrekonstruowany');
reconstruction_error = x1(1:length(reconstructed_signal)) - reconstructed_signal;
%reconstructed_signal_toerr = reconstructed_signal(1:length(x1));
figure(3);

plot(t1(1:length(reconstruction_error)), reconstruction_error, 'b-');
legend('błędy rekonstrukcji');