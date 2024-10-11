function L = lab4_2(A)
    [N, M] = size(A);
    
    if N ~= M || ~issymmetric(A)
        error('Macierz musi być kwadratowa i symetryczna.');
    end
    
    L = zeros(N, N);

    for i = 1:N
        for j = 1:i
            if i == j
                suma = sum(L(i, 1:j-1).^2);
                L(i, j) = sqrt(A(i, i) - suma);
            else
                suma = sum(L(i, 1:j-1) .* L(j, 1:j-1));
                L(i, j) = (A(i, j) - suma) / L(j, j);
            end
        end
    end
end
