clear all; close all; clc;

%Parametry
numFrames = 10;  %Liczba ramek
mbSize = 16;     %Rozmiar bloku
p = 8;           %Zakres poszukiwania

%Wczytanie ramek
frames = cell(numFrames, 1);
for k = 1:numFrames
    filename = sprintf('000000%02d.png', k);
    frames{k} = imread(filename);
    if size(frames{k}, 3) == 3
        frames{k} = rgb2gray(frames{k});
    end
end

%Pierwsza ramka jako referencyjna
refFrame = double(frames{1});
[M, N] = size(refFrame);
%Stabilizacja obrazu
stabilizedFrames = cell(numFrames, 1);
stabilizedFrames{1} = frames{1};

for k = 2:numFrames
    curFrame = double(frames{k});
    motionVect = motionEstES(curFrame, refFrame, mbSize, p);
    
    % Obliczenie średniego przesunięcia
    avg_mvx = mean(motionVect(3, :));
    avg_mvy = mean(motionVect(4, :));
    
    % Przesunięcie obrazu
    [X, Y] = meshgrid(1:N, 1:M);
    Xq = X - avg_mvx;
    Yq = Y - avg_mvy;
    stabilizedFrame = interp2(X, Y, curFrame, Xq, Yq, 'bilinear', 0);
    stabilizedFrames{k} = uint8(stabilizedFrame);
end

% Zapisanie przetworzonych ramek do nowego pliku wideo
outputVideo = VideoWriter('stabilized_video.avi');
open(outputVideo);
for k = 1:numFrames
    writeVideo(outputVideo, stabilizedFrames{k});
end
close(outputVideo);

function [motionVect] = motionEstES(imgP, imgI, mbSize, p)
    [row, col] = size(imgI);
    row = floor(row / mbSize) * mbSize;
    col = floor(col / mbSize) * mbSize;

    vectors = zeros(4, (row * col) / mbSize^2);
    mbCount = 1;
    
    for i = 1 : mbSize : row
        for j = 1 : mbSize : col
            cost = 10^20;
            pos = [0 0];
            for m = -p : p
                for n = -p : p
                    refBlkVer = i + m; % wiersz/wspolrzedna pionowa;
                    refBlkHor = j + n; % kolumna/wspolrzedna pozioma;
                    if ( refBlkVer < 1 || refBlkVer + mbSize - 1 > row || refBlkHor < 1 || refBlkHor + mbSize - 1 > col)
                        continue;
                    end
                    % wyznaczenie kosztu:
                    temp_cost = sum(sum(abs(imgP(i:i+mbSize-1, j:j+mbSize-1) - imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1))));
                    if (temp_cost < cost)
                        cost = temp_cost;
                        pos = [m n];
                    end
                end
            end
            vectors(1, mbCount) = i;
            vectors(2, mbCount) = j;
            vectors(3, mbCount) = pos(1); % wiersz/wspolrzedna pionowa
            vectors(4, mbCount) = pos(2); % kolumna/wspolrzedna pozioma
            mbCount = mbCount + 1;
        end
    end
    motionVect = vectors;
end
