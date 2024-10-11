N = 1000;
x = sin(2*pi/N*(0:N-1));

% szum o sile 
strengt = [0.01, 0.1, 0.5];
err_d1 = zeros(length(strengt), N);
err_d2 = zeros(length(strengt), N);

for s = 1:length(strengt)
    x_n = x + strengt(s) * randn(1, N);
    
    % pochodne numeryczne
    for k = 2:N-1
        d1_numerical = (x_n(1+k:N) - x_n(1:N-k)) / k;
        d2_numerical = (x_n(1+k:N) - 2*x_n(1:N-k) + x_n(1-k:N-2*k)) / k^2;
        
        % pochodne rzeczywiste
        d1_actual = cos(2*pi/N*(k:N-1));
        d2_actual = -sin(2*pi/N*(k:N-1));
        
        % srednie bledy przyblizenia
        err_d1(s, k) = mean(abs(d1_numerical - d1_actual));
        err_d2(s, k) = mean(abs(d2_numerical - d2_actual));
    end
end

% najmnuejszy blad
[min_error_d1, idx_d1] = min(err_d1, [], 2);
[min_error_d2, idx_d2] = min(err_d2, [], 2);

disp('Wyniki dla pierwszej pochodnej:');
disp(['Najmniejszy błąd dla różnych wartości szumu: ', num2str(min_error_d1')]);
disp(['Odpowiadające wartości k: ', num2str(idx_d1')]);

disp('Wyniki dla drugiej pochodnej:');
disp(['Najmniejszy błąd dla różnych wartości szumu: ', num2str(min_error_d2')]);
disp(['Odpowiadające wartości k: ', num2str(idx_d2')]);
