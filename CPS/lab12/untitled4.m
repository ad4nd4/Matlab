% 1. Generowanie współczynników wagowych dla filtrów LP i HP
% Low Pass filter (Hamming window)
lp_filter = fwind1(fspecial('gaussian', [32 32], 5), hamming(32)*hamming(32)');

% High Pass filter (Sobel)
sobel_operator = fspecial('sobel');
hp_filter = fwind1(sobel_operator, hamming(32)*hamming(32)');

% 2. Rysowanie rozkładu wartości filtrów
figure;
subplot(2,2,1);
mesh(lp_filter);
title('Low Pass Filter Weights');
subplot(2,2,2);
mesh(hp_filter);
title('High Pass Filter Weights');

subplot(2,2,3);
imshow(lp_filter, []);
title('Low Pass Filter');
subplot(2,2,4);
imshow(hp_filter, []);
title('High Pass Filter');

% 3. Transformacja kosinusowa filtrów
dct_lp_filter = dct2(lp_filter);
dct_hp_filter = dct2(hp_filter);

figure;
subplot(2,2,1);
imshow(log(abs(dct_lp_filter)), []);
title('DCT2 of Low Pass Filter');
subplot(2,2,2);
imshow(log(abs(dct_hp_filter)), []);
title('DCT2 of High Pass Filter');

subplot(2,2,3);
mesh(log(abs(dct_lp_filter)));
title('DCT2 of Low Pass Filter (mesh)');
subplot(2,2,4);
mesh(log(abs(dct_hp_filter)));
title('DCT2 of High Pass Filter (mesh)');

% 4. Wczytanie obrazu testowego i filtracja
lena = imread('lena.png');
lena_gray = rgb2gray(lena);

% Filtracja z użyciem LP filtra
filtered_lp = filter2(lp_filter, lena_gray);
filtered_hp = filter2(hp_filter, lena_gray);

% 5. Wyświetlenie obrazu i jego widma przed i po filtracji
figure;
subplot(2,3,1);
imshow(lena_gray, []);
title('Original Image');
subplot(2,3,2);
imshow(filtered_lp, []);
title('Filtered Image (LP)');
subplot(2,3,3);
imshow(filtered_hp, []);
title('Filtered Image (HP)');

subplot(2,3,4);
imshow(log(abs(dct2(lena_gray))), []);
title('DCT2 of Original Image');
subplot(2,3,5);
imshow(log(abs(dct2(filtered_lp))), []);
title('DCT2 of LP Filtered Image');
subplot(2,3,6);
imshow(log(abs(dct2(filtered_hp))), []);
title('DCT2 of HP Filtered Image');

% 6. Analiza wpływu rozmiaru maski filtra i filtru Gaussa
% Różne rozmiary maski filtra LP
lp_filter_16 = fwind1(fspecial('gaussian', [16 16], 5), hamming(16)*hamming(16)');
filtered_lp_16 = filter2(lp_filter_16, lena_gray);

figure;
subplot(1,2,1);
imshow(filtered_lp, []);
title('Filtered Image (LP 32x32)');
subplot(1,2,2);
imshow(filtered_lp_16, []);
title('Filtered Image (LP 16x16)');

% Filtr Gaussa z różnymi wartościami sigma
gauss_filter1 = fspecial('gaussian', [32 32], 2);
gauss_filter2 = fspecial('gaussian', [32 32], 5);

filtered_gauss1 = filter2(gauss_filter1, lena_gray);
filtered_gauss2 = filter2(gauss_filter2, lena_gray);

figure;
subplot(1,2,1);
imshow(filtered_gauss1, []);
title('Filtered Image (Gaussian sigma=2)');
subplot(1,2,2);
imshow(filtered_gauss2, []);
title('Filtered Image (Gaussian sigma=5)');
