disp('Rownomierny R[0,1] --> Normalny (0,1)')
N = 10000;
r1 = rand(1,N);
r2 = rand(1,N);
n1 = sqrt(-2*log(r1)) .* cos(2*pi*r2);
n2 = sqrt(-2*log(r1)) .* sin(2*pi*r2);

% Parametry przekształcenia
mean = 7.5;         %+ średnia
sigma = 2.8;      % +odchylenie standardowe

%przekształcanie 
n1_tr = mean + sigma * n1;
n2_tr = mean + sigma * n2;

%wykresiki
figure;
subplot(111); plot(n1,n2,'b*'); pause
subplot(221);
hist(n1, 20);
title('Histogram - n1');
subplot(222);
hist(n2, 20);
title('Histogram - n2');

subplot(223);
hist(n1_tr, 20);
title(['Histogram - n1 (', num2str(mean), ',', num2str(sigma), ')']);

subplot(224);
hist(n2_tr, 20);
title(['Histogram - n2 (', num2str(mean), ',', num2str(sigma), ')']);
