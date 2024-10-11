clear all; close all;

N = 20;
%macierz
A = zeros(N);

for k = 0:N-1
    for n = 0:N-1
        if k == 0
            sk = sqrt(1/N);
        else
            sk = sqrt(2/N);
        end
        A(k+1,n+1) = sk * cos(pi * k / N * (n + 0.5));
    end
end
%ortonormalnosc
Orthonormal = true;
for n = 1:N
    for m = 1:N
        if n ~= m
            %iloczyn skalarny różnych wierszy
            scal = sum(A(n,:).*A(m,:));  %dot(A(i,:), A(j,:)); 
            if abs(scal) > 1e-10 %norma
                Orthonormal = false;
                break;
            end
        else
            %norma
            if abs(norm(A(n,:)) - 1) > 1e-10
                Orthonormal = false;
                break;
            end
        end
    end
    if ~Orthonormal
        break;
    end
end

if Orthonormal
    disp('Wszystkie wektory (wiersze macierzy) są do siebie ortonormalne.');
else
    disp('Wektory (wiersze macierzy) nie są do siebie ortonormalne.');
end
