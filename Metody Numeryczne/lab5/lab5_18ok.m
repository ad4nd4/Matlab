clear all; close all;
img = imread('Lena256.bmp');

% Rotation angle
a = pi/30;
R = [cos(a) -sin(a); sin(a) cos(a)];

% Rotated image
[M, N] = size(img);
[X, Y] = meshgrid(1:M, 1:N);
[XR, YR] = meshgrid(1:M, 1:N);
for m = 1:M
    for n = 1:N
        work = R * [X(m, n); Y(m, n)];
        XR(m, n) = work(1, 1);
        YR(m, n) = work(2, 1);
    end
end
img_rotated = interp2(X, Y, double(img), XR, YR, 'linear');

% int
methods = {'nearest', 'linear', 'spline', 'cubic'};

%mse_values = zeros(1, numel(methods));
%mae_values = zeros(1, numel(methods));

figure;
subplot(2, 3, 1);
imshow(img);
title('Original Image');

subplot(2, 3, 2);
imshow(uint8(img_rotated));
title('Rotated Image');

for i = 1:numel(methods)
    img_rotated_no_nan = img_rotated;
    img_rotated_no_nan(isnan(img_rotated_no_nan)) = 0;

    % int
    img_interpolated = interp2(X, Y, img_rotated_no_nan, XR, YR, methods{i}, 0); % 0 specifies to use zero for NaN values

   
    subplot(2, 3, i+2);
    imshow(uint8(img_interpolated));
    title(['Interpolated - ', methods{i}]);

    %mse_values(i) = immse(img_rotated_no_nan, img_interpolated);
    %mae_values(i) = mean(abs(double(img_rotated_no_nan(:)) - double(img_interpolated(:))));
    
end


%Display results
%disp('Method  | MSE      | MAE');
%disp('------------------------');
%for i = 1:numel(methods)
%    disp([methods{i}, ' | ', num2str(mse_values(i)), ' | ', num2str(mae_values(i))]);
%end
