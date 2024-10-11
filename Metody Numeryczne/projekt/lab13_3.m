lambda = 2;
%dystrybuanta
x = 0:0.01:3;
F = 1 - exp(-lambda * x);

% Wykres dystrybuanty
figure;
plot(x, F);
xlabel('x');
ylabel('F(x)');
title('F(x)');
grid;
pause;

N = 10000;
r = rand(1, N);
generated_x = - (1 / lambda) * log(1 - r);

% Wykresy rozkładu jednostajnego i wykładniczego oraz histogramy
figure;
subplot(2,2,1);
plot(r, 'b.');
title('Rozkład jednostajny R[0,1]');
subplot(2,2,2);
hist(r, 20);
title('Histogram - Rozkład jednostajny');

subplot(2,2,3);
plot(x, 'b.');
title('Rozkład wykładniczy');
subplot(2,2,4);
hist(generated_x, 20);
title('Histogram - Rozkład wykładniczy');

pause;
