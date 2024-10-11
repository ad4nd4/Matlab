clear all; close all;

load('adsl_x.mat');
M = 32;
N = 512;
K=4;

prefix = repmat(x(end-M+1:end), K, 1); %próbkę prefiksu, która będzie używana do wyznaczania korelacji krzyżowej.
correlation = MyCorrelation(x, prefix);
start_indices = zeros(K, 1);

for l = 1:K
    block_start = (l-1)*(M+N)+1;
    block_end = l*(M+N);
    [~, max_index] = max(correlation(block_start:block_start+M-1));
    start_indices(l) = block_start + max_index - 1, %Wartości start_indices powinny być wektorem o długości cztery,co odpowiada strukturze sygnału ADSL opisanej w zadaniu.
    
end
function [correlation] = MyCorrelation(x, y)
    lenX = length(x);
    lenY = length(y);
    correlation = zeros(1, lenX+lenY-1);
    for k = 1:(lenX+lenY-1)
        sum = 0;
        for l = max(1, k+1-lenY):min(k, lenX)
            sum = sum + x(l) * y(k-l+1);
        end
        correlation(k) = sum;
    end
end