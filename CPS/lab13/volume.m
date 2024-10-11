clear all; close all;

% Wejście do katalogu z DICOM-ami
cd('CT_1'); % zmień na odpowiedni katalog z plikami DICOM

%% ---- Ustalenie wymiaru przekroju
files = dir('*.dcm');
firstFile = files(1).name;
I = dicomread(firstFile); 
imshow(I, []); % wczytanie pierwszego z brzegu przekroju
info = dicominfo(firstFile);

Nx = info.Rows;  % znalezienie wymiaru przekroju
Ny = info.Columns; % znalezienie wymiaru przekroju

%% Zapisywanie przekrojów do macierzy 3D
numSlices = length(files);
CT = zeros(Nx, Ny, numSlices);  % macierz zer do zapisywania kolejnych przekrojów DICOM
kontrolaZ = zeros(1, numSlices);
kontrolaSeries = zeros(1, numSlices);
kontrolaSlice = zeros(1, numSlices);
kontrolaPosition = zeros(numSlices, 3);
kontrolaSpacing = zeros(numSlices, 2);

for i = 1:numSlices
    % Zapisywanie przekrojów
    slice = dicomread(files(i).name);
    info = dicominfo(files(i).name);
    CT(:,:,i) = slice;
    
    % Zapisywanie potrzebnych metadanych
    kontrolaZ(i) = info.SliceLocation;
    kontrolaSeries(i) = info.SeriesNumber;
    kontrolaSlice(i) = info.SliceThickness;
    kontrolaPosition(i, :) = info.ImagePositionPatient;
    kontrolaSpacing(i, :) = info.PixelSpacing;
end

%% Weryfikacja poprawności zapisania danych
figure;
plot(kontrolaSpacing(:, 1), 'b'); hold on;
plot(kontrolaSlice, 'g');
plot(kontrolaPosition(:, 3), 'r');
plot(kontrolaZ, 'c'); grid on;
legend('Pixel Spacing', 'SliceThickness', 'ImagePositionPatient', 'SliceLocation');
title('Weryfikacja metadanych');

figure;
PS_sl_num = round(size(CT, 3) / 2); % wybór środkowego przekroju
CT_sp = squeeze(CT(:, :, PS_sl_num));
CT_sp = imresize(CT_sp, [512 512], 'bilinear');
imshow(CT_sp, [1000 1100]);
title('Środkowy przekrój w płaszczyźnie strzałkowej');

%% Wyznaczenie progów jasności za pomocą imcontrast
middleImage = CT(:, :, PS_sl_num);
figure; imshow(middleImage, []);
imcontrast;

lowThreshold = 50;  % dolny próg
highThreshold = 200; % górny próg

%% Wyświetlanie przekrojów w pętli z uwzględnieniem progów jasności
figure;
for k = 1:numSlices
    imshow(CT(:, :, k), [lowThreshold highThreshold]);
    title(sprintf('Przekrój %d', k));
    pause(0.1);  % Opóźnienie dla lepszego oglądania
end

%% Wizualizacja 3D za pomocą funkcji isosurface
figure;
isosurface(CT, mean([lowThreshold, highThreshold]));
title('Izopowierzchnia woluminu CT');
xlabel('X'); ylabel('Y'); zlabel('Z');
