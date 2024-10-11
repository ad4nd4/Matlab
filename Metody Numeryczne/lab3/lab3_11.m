clear all; close all;
A = load("babia_gora.dat");

figure; grid; plot3(A(:,1), A(:,2), A(:,3), 'b.');

a = 1; b = 2; c = 0.1; % wartości skalowania
S = [a, 0, 0;
     0, b, 0;
     0, 0, c];
AS = S*A';
figure; grid; plot3(AS(1,:), AS(2,:), AS(3,:), 'b.'); title('skalowanie');

x = 99; y = 130; z = 1420; % wartość translacji
T = zeros(length(A(:,1)), 3);
T(:,1) = x;
T(:,2) = y;
T(:,3) = z;

AT = T+A;
figure; grid; plot3(AT(:,1), AT(:,2), AT(:,3), 'b.'); title('translacja');

XX = A*S' + T;
figure; grid; plot3(XX(:,1), XX(:,2), XX(:,3), 'b.'); title('nowe wsp')