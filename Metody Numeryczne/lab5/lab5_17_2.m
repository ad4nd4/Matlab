clear all; close all;

[dataX, dataY, dataZ] = prepareData("babia_gora.dat");

% Interpolation
methods = {'nearest', 'linear', 'cubic', 'natural'};

for i = 1:length(methods)

    indices = randperm(length(dataX), round(0.9 * length(dataX))); 

    [Xi, Yi] = meshgrid(min(dataX):(max(dataX)-min(dataX))/10:max(dataX), min(dataY):(max(dataY)-min(dataY))/10:max(dataY));

    out = griddata(dataX(indices), dataY(indices), dataZ(indices), Xi, Yi, methods{i});

    figure;
    surf(out);
    title(sprintf('Interpolation using %s', methods{i}));
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    colormap(jet);
end

% Error
indices = 1:2:length(dataX);
x = dataX(indices);
y = dataY(indices);
z = dataZ(indices);

function err = calculateError(comp, out)
    err = sum((comp - out).^2) / numel(comp);
end

function [x, y, z] = prepareData(filename)
    babia_gora = load(filename);
    x = babia_gora(:, 1);
    y = babia_gora(:, 2);
    z = babia_gora(:, 3);
end


