% interp_obiekt3D.m
clear all; close all;

% Załaduj dane topograficzne
load('babia_gora.dat'); X = babia_gora;

% Wyświetl dane topograficzne
figure; grid; plot3(X(:,1), X(:,2), X(:,3), 'b.'); title('Topographic Data'); pause

% Pobierz x, y, z
x = X(:,1); y = X(:,2); z = X(:,3);

% Zakres zmiennych x i y
xvar = min(x) : (max(x)-min(x))/200 : max(x);
yvar = min(y) : (max(y)-min(y))/200 : max(y);

% Utwórz siatkę interpolacyjną Xi, Yi
[Xi, Yi] = meshgrid(xvar, yvar);

% Interpolacja nearest-neighbor
out_nearest = griddata(x, y, z, Xi, Yi, 'nearest');

% Interpolacja bilinear
out_bilinear = griddata(x, y, z, Xi, Yi, 'linear');

% Interpolacja bicubic
out_bicubic = griddata(x, y, z, Xi, Yi, 'cubic');

% Interpolacja spline
out_spline = griddata(x, y, z, Xi, Yi, );

% Wyświetl wszystkie wyniki jednocześnie
figure;
subplot(2,2,1); surf(Xi, Yi, out_nearest, 'FaceColor', 'interp', 'EdgeColor', 'none');
title('Nearest-Neighbor Interpolation'); colorbar;

subplot(2,2,2); surf(Xi, Yi, out_bilinear, 'FaceColor', 'interp', 'EdgeColor', 'none');
title('Bilinear Interpolation'); colorbar;

subplot(2,2,3); surf(Xi, Yi, out_bicubic, 'FaceColor', 'interp', 'EdgeColor', 'none');
title('Bicubic Interpolation'); colorbar;

subplot(2,2,4); surf(Xi, Yi, out_spline, 'FaceColor', 'interp', 'EdgeColor', 'none');
title('Spline Interpolation'); colorbar;

% Dostosuj ustawienia wykresu
axis tight;
