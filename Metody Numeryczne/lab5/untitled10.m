
clear all; close all;

X = imread("lena256.bmp");

pixelDist = 50;

buffer = X(:, 2:pixelDist:end);
imgReduced = buffer(2:pixelDist:end,:);

buffer = X(:,2:9.85:end);
imgToDraw = buffer(2:9.5:end,:);
mesh(imgToDraw); axis equal;

% imgToDraw - poucinane wartosci
% X - oryginalny obraz