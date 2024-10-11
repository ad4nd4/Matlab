% Generowanie zepsutej macierzy DCT
N = 100;
A_messd = zeros(N);
for k = 1:N
    for n = 1:N
        if k == 1
            sk = sqrt(1/N);
        else
            sk = sqrt(2/N);
        end
        A_messd(k,n) = sk * cos(pi * (2*(n-1) + 1) * (k-0.25) / (2 * N)); %ind k
    end
end

%ortog?
Orthogonality = round(A_messd' * A_messd, 10); %A_messd' * A_messd; 
disp('Czy zepsuta macierz DCT jest ortogonalna:');
disp(Orthogonality == eye(N));

%generowanie
x = randn(N, 1);

%analiza
X_messd = A_messd * x;

%rekonstrukcja
S_messd = inv(A_messd);
xs_messd = S_messd * X_messd;

disp('Czy xs == x po zepsutej transformacji DCT:');
disp(norm(xs_messd - x) < 1e-10);
