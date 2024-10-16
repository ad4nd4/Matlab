function [ points ] = searchForHighVariation( img, blockSize )
% search for 4 poits with big variation in:
% left upper corner
% right upper corner
% left bottom corner
% right bottom corner 

points = zeros(4,2);
[row col] = size( img );

% left - upper
varMax = 0;
for x = ceil(col*0.1) : ceil(col*0.4)
    for y = ceil(row*0.1) : ceil(row*0.5)
        patch = img(y:y+blockSize-1, x:x+blockSize-1);
        varPatch = var( reshape(patch,1,blockSize*blockSize) );
        if varPatch > varMax
            varMax = varPatch;
            points(1,:) = [x,y];
        end
    end
end

% righ - upper
varMax = 0;
for x = ceil(col*0.6) : ceil(col*0.9)
    for y = ceil(row*0.1) : ceil(row*0.5)
        patch = img(y:y+blockSize-1, x:x+blockSize-1);
        varPatch = var( reshape(patch,1,blockSize*blockSize) );
        if varPatch > varMax
            varMax = varPatch;
            points(2,:) = [x,y];
        end
    end
end

% left - bottom
varMax = 0;
for x = ceil(col*0.1) : ceil(col*0.4)
    for y = ceil(row*0.6) : ceil(row*0.9)
        patch = img(y:y+blockSize-1, x:x+blockSize-1);
        varPatch = var( reshape(patch,1,blockSize*blockSize) );
        if varPatch > varMax
            varMax = varPatch;
            points(3,:) = [x,y];
        end
    end
end


% righ - bottom
varMax = 0;
for x = ceil(col*0.6) : ceil(col*0.9)
    for y = ceil(row*0.6) : ceil(row*0.9)
        patch = img(y:y+blockSize-1, x:x+blockSize-1);
        varPatch = var( reshape(patch,1,blockSize*blockSize) );
        if varPatch > varMax
            varMax = varPatch;
            points(4,:) = [x,y];
        end
    end
end

figure;
imagesc( img ); colormap gray;
hold on;
drawRectangle( points(1,1), points(1,2), blockSize, blockSize );
drawRectangle( points(2,1), points(2,2), blockSize, blockSize );
drawRectangle( points(3,1), points(3,2), blockSize, blockSize );
drawRectangle( points(4,1), points(4,2), blockSize, blockSize );
hold off;

end

function drawRectangle( x, y, dx, dy )

% upper
line( [x, x+dx], [y, y],  'Color', 'r', 'LineWidth',2 );
% bottom
line( [x, x+dx], [y+dy, y+dy],  'Color', 'r', 'LineWidth',2  );
% left
line( [x, x], [y, y+dy],  'Color', 'r', 'LineWidth',2  );
% right
line( [x+dy, x+dy], [y, y+dy],  'Color', 'r', 'LineWidth',2  );
end