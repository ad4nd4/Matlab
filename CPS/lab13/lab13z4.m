clear all; close all; clc;

%Katalog z danymi DICOM
folder = 'CT_1';

%Wczytanie pierwszego przekroju
files = dir(fullfile(folder, '*.dcm'));
info = dicominfo(fullfile(folder, files(1).name));
slice = dicomread(info);
[rows, cols] = size(slice);

%Sprawdzenie zgodności rozmiarów
assert(rows == info.Rows && cols == info.Columns, 'Rozmiary przekroju nie zgadzają się z metadanymi');

%Wczytanie wszystkich przekrojów
numSlices = length(files);
volume = zeros(rows, cols, numSlices);

%Wczytanie metadanych
positions = zeros(numSlices, 3);  % dla ImagePositionPatient
locations = zeros(numSlices, 1);  % dla SliceLocation
pixelSpacing = zeros(numSlices, 2); % dla PixelSpacing
sliceThickness = zeros(numSlices, 1); % dla SliceThickness

for k = 1:numSlices
    filename = fullfile(folder, files(k).name);
    info = dicominfo(filename);
    slice = dicomread(info);
    volume(:, :, k) = slice;
    
    positions(k, :) = info.ImagePositionPatient;
    locations(k) = info.SliceLocation;
    pixelSpacing(k, :) = info.PixelSpacing;
    sliceThickness(k) = info.SliceThickness;
end

%Sprawdzenie poprawności zapisanych danych
figure;
plot(1:numSlices, pixelSpacing(:, 1), 'r', 1:numSlices, sliceThickness, 'g', 1:numSlices, positions(:, 3), 'b', 1:numSlices, locations, 'k');
legend('PixelSpacing', 'SliceThickness', 'ImagePositionPatient', 'SliceLocation');
title('Metadane przekrojów');

%środkowy przekrój w płaszczyźnie strzałkowej
middlePrzekroj = squeeze(volume(:, round(cols/2), :));
figure;
imshow(imresize(middlePrzekroj, [512, 512]), []);
title('Środkowy przekrój w płaszczyźnie strzałkowej');

%progi
Obrazmiddle = volume(:, :, round(numSlices / 2));
figure; imshow(Obrazmiddle, []);
imcontrast;
pause;
lowThreshold = 1001;  % dolny próg 864
highThreshold = 1064; % górny próg 1130

figure;
for k = 1:numSlices
    imshow(volume(:, :, k), [lowThreshold highThreshold]);
    title(sprintf('Przekrój %d', k));
    pause(0.1);
end
%wizualizacja
figure;
isosurface(volume, mean([lowThreshold, highThreshold]));
title('Izopowierzchnia woluminu CT');
xlabel('X'); ylabel('Y'); zlabel('Z');
