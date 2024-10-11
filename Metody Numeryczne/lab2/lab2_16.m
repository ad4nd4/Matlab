% clear all; close all;

a = 0.5;
c = 0.490:0.001:0.500;
N = 1000;

cond = @(b, c) b / sqrt(b.^2 - 4 * a * c);
x1 = @(b, c) (-b - sqrt(b.^2 - 4 * a * c)) / (2 * a);

for k = 1:3
    fprintf('______________\n');
    c_ = c(randi(length(c)));      %losowe c z zakresu c
    b = 1 + 0.001 * randn(1, N);   %losowe b od 1 do N (zmienione jak w treści)
    
    arr = zeros(1, N);             %tablica z miejcami od 1 do N
    
    for l = 1:N
        arr(l) = x1(b(l), c_);     %wzór na x1 od (b,c)
    end
    
    mean_ = mean(arr);
    std_ = std(arr);
 
    disp("c ="), disp(c_)
    disp("mean ="), disp(mean_)
    disp("standard deviation ="), disp(std_)
end