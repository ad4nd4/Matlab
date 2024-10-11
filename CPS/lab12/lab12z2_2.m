close all; clear all; clc;
%Low Pass filtr gausowski
lp_fil = fspecial('gaussian', [32 32], 5);

% High Pass filtr laplasjan
hp_fil = fspecial('laplacian', 0.2);

%rozkład wartości filtrów
figure;
subplot(2,2,1);
mesh(lp_fil);
title('(wagi) Low Pass Filter');
subplot(2,2,2);
mesh(hp_fil);
title('(wagi) High Pass Filter');

subplot(2,2,3);
imshow(lp_fil, []);
title('Low Pass Filter');
subplot(2,2,4);
imshow(hp_fil, []);
title('High Pass Filter');

% 3. Transformacja kosinusowa filtrów
dct_lp_filter = dct2(lp_fil);
dct_hp_filter = dct2(hp_fil);

figure;
subplot(2,2,1);
imshow(log(abs(dct_lp_filter)), []);
title('Low Pass Filter DCT2');
subplot(2,2,2);
imshow(log(abs(dct_hp_filter)), []);
title('High Pass Filter DCT2');

subplot(2,2,3);
mesh(log(abs(dct_lp_filter)));
title('Low Pass Filter DCT2 (mesh)');
subplot(2,2,4);
mesh(log(abs(dct_hp_filter)));
title('High Pass Filter DCT2 (mesh)');

%obrazu testowy i filtracja
lena = imread('lena512.png');

% Filtracja z użyciem LP filtra
filtered_lp = filter2(lp_fil, lena);
filtered_hp = filter2(hp_fil, lena);

%obraz i widmo przed i po filtracji
figure;
subplot(2,3,1);
imshow(lena, []);
title('Original Image');
subplot(2,3,2);
imshow(filtered_lp, []);
title('Filtered Image (LP)');
subplot(2,3,3);
imshow(filtered_hp, []);
title('Filtered Image (HP)');

subplot(2,3,4);
imshow(log(abs(dct2(lena))), []);
title('DCT2 of Original Image');
subplot(2,3,5);
imshow(log(abs(dct2(filtered_lp))), []);
title('DCT2 of LP Filtered Image');
subplot(2,3,6);
imshow(log(abs(dct2(filtered_hp))), []);
title('DCT2 of HP Filtered Image');

%wpływ rozmiaru maski filtra i filtru Gaussa
%inne rozmiary maski
lp_filter_16 = fspecial('gaussian', [16 16], 5);
filtered_lp_16 = filter2(lp_filter_16, lena);

figure;
subplot(1,2,1);
imshow(filtered_lp, []);
title('Filtered Image (LP 32x32)');
subplot(1,2,2);
imshow(filtered_lp_16, []);
title('Filtered Image (LP 16x16)');

% Filtr Gaussa z różnymi wartościami sigma
gauss_fil1 = fspecial('gaussian', [32 32], 2);
gauss_fil2 = fspecial('gaussian', [32 32], 5);

fil_gauss1 = filter2(gauss_fil1, lena);
fil_gauss2 = filter2(gauss_fil2, lena);

figure;
subplot(1,2,1);
imshow(fil_gauss1, []);
title('Przefiltrowany (Gaussian sigma=2)');
subplot(1,2,2);
imshow(fil_gauss2, []);
title('Przefiltrowany (Gaussian sigma=5)');
