% motion estimation
% 07.01.2015 Kwant

clear all;
close all;

img0 = imread('00000001.png');
img0 = double( img0 );
points = searchForHighVariation( img0, 12 );

figure,
for l=3:9
    name = sprintf('0000000%d.png',l)
    imgX = imread(name);
    imgX = double(imgX);
    
    mv = motionEstES_spare( img0, imgX, 8, 64, points )
    % mv(1,:) wiersz = row
    % mv(2,:) kolumna = col
    imagesc( img0 ); colormap gray; hold on;
    quiver( mv(1,:), mv(2,:), mv(3,:)+0.1, mv(4,:)+0.1, 2, 'r' ); 
    hold off;
%     pause;    
    
    [row, col] = size(img0);
    xyv = zeros(4, row*col);
    idx = 1;
    for r=1:row
        for c=1:col
            d = zeros(length(mv), 1);
            for n=1:length(mv)
                d(n) = sqrt( (r-mv(1,n))^2 + (c-mv(2,n))^2 );
            end
            rx = sum(mv(3,:)./d') * sum(d);
            ry = sum(mv(4,:)./d') * sum(d);
            xyv(:,idx) = [r; c; rx; ry];
            idx = idx+1;
        end
    end

    figure,
    quiver( xyv(1,:), xyv(2,:), xyv(3,:)+0.1, xyv(4,:)+0.1, 3, 'r' ); 
    pause
    
end

% 
% 
% 
% 
% figure, 
% subplot(1,2,1), imagesc( imgP ); colormap gray; hold on;
% quiver( mv(2,:), mv(1,:), mv(4,:), mv(3,:), 0, 'r' );
% set(gca, 'xColor','white'); set(gca, 'yColor','white'); grid; axis square;
% axis([400,500,150,200]);
% hold off;
% 
% subplot(1,2,2), imagesc( imgL ); colormap gray; 
% set(gca, 'xColor','white'); set(gca, 'yColor','white'); grid; axis square;
% axis([400,500,150,200]);
% 
% figure, 
% subplot(1,2,1), imagesc( imgP ); colormap gray; hold on;
% quiver( mv(2,:), mv(1,:), mv(4,:), mv(3,:), 'r' );
% set(gca, 'xColor','white'); set(gca, 'yColor','white'); grid; axis square;
% hold off;
% 
% subplot(1,2,2), imagesc( imgL ); colormap gray; 
% set(gca, 'xColor','white'); set(gca, 'yColor','white'); grid; axis square;
