function [motionVect] = motionEstES_spare(imgP, imgI, mbSize, p, points),
% [motionVect] = motionEstES(imgP, imgI, mbSize, p),
%
% Wyznaczenie wektorow ruchu metoda pelnego przeszukiwania;
% imgP - obraz dla ktorego szukamy wektorow ruchu;
% imgI - obraz odniesienia;
% mbSize - rozmiar bloku;
% p - zakres poszukiwania;
% points(n,2) - begining of vector search
% motionVect - wektory ruchu dla kolejnych blokow w kolejnosci od lewej do prawej i z gory na dol;
%
% Przyklad 18.3.
% m-plik (funkcyjny): motionEstES.m
%
% Cyfrowe przetwarzanie sygnalow. Podstawy, multimedia, transmisja. PWN, Warszawa, 2014.
% Rozdzial 18. Kompresja obrazow.
% Autor rozdzialu: Marek Domanski.
%
% Wiecej na stronie internetowej: http://teledsp.kt.agh.edu.pl
%
% Opracowanie przykladu: kwiecien 2014 r./MD.

[row col] = size(imgI);
vectors = zeros(4,size(points,1));
mbCount = 1;

for n = 1:size(points,1)
    i = points(n,1);
    j = points(n,2);
    
    % for i = 1 : mbSize : row-mbSize+1,
    %     for j = 1 : mbSize : col-mbSize+1,
    cost=10^20;
    pos=[0 0];
    for m = -p : p,
        for n = -p : p,
            refBlkVer = i + m; % wiersz/wspolrzedna pioniowa;
            refBlkHor = j + n; % kolumna/wspolrzedna pozioma;
            if ( refBlkVer < 1 || refBlkVer+mbSize-1 > row || refBlkHor < 1 || refBlkHor+mbSize-1 > col),
                continue;
            end;
            % wyznaczenie kosztu:
            temp_cost = costFuncSAD(imgP(i:i+mbSize-1,j:j+mbSize-1),imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1));
            if (temp_cost < cost),
                cost=temp_cost;
                pos=[m n];
            end;
        end;
    end;
    vectors(1,mbCount) = i;
    vectors(2,mbCount) = j;
    vectors(3,mbCount) = pos(1); % wiersz/wspolrzedna pioniowa
    vectors(4,mbCount) = pos(2); % kolumna/wspolrzedna pozioma
    mbCount = mbCount + 1;
end;
motionVect = vectors;

% KONIEC PRZYKLADU 18.3.