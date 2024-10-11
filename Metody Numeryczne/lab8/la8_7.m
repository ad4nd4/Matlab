clear all; close all;

[X, map] = imread('pluskwiak.JPG');  % wczytaj obraz
wymiary = size(X); 

X = double(X);  % pokaz go
figure; imshow(uint8(X)); title('Oryginal');
colormap(map);

% Konwersja obrazu do przestrzeni barw RGB
RGB_image = ind2rgb(X, map);
R = RGB_image(:,:,1); % czerwony kanał
G = RGB_image(:,:,2); % zielony kanał
B = RGB_image(:,:,3); % niebieski kanał

[U_R, S_R, V_R] = svd(R);  % dekompozycja SVD dla czerwonego kanału
[U_G, S_G, V_G] = svd(G);  % dekompozycja SVD dla zielonego kanału
[U_B, S_B, V_B] = svd(B);  % dekompozycja SVD dla niebieskiego kanału

% Pętla dla różnych ilości osobliwych
mv = [1, 2, 3, 4, 5, 10, 15, 20, 25, 50];
errors = zeros(1, length(mv));
compression_ratios = zeros(1, length(mv));

for i = 1:length(mv)  % PETLA - START
    mask_R = zeros(size(S_R));  % maska zerująca wartości osobliwe dla czerwonego kanału
    mask_R(1:mv(i), 1:mv(i)) = 1;  % wstaw "1" pozostawiajace najwieksze w.o.
    
    mask_G = zeros(size(S_G));  % maska zerująca wartości osobliwe dla zielonego kanału
    mask_G(1:mv(i), 1:mv(i)) = 1;  % wstaw "1" pozostawiajace najwieksze w.o.
    
    mask_B = zeros(size(S_B));  % maska zerująca wartości osobliwe dla niebieskiego kanału
    mask_B(1:mv(i), 1:mv(i)) = 1;  % wstaw "1" pozostawiajace najwieksze w.o.

    % Synteza i pokaz obrazu zrekonstruowanego
    reconstructed_image_R = U_R * (S_R .* mask_R) * V_R';
    reconstructed_image_G = U_G * (S_G .* mask_G) * V_G';
    reconstructed_image_B = U_B * (S_B .* mask_B) * V_B';
    
    % Składanie obrazu z trzech kanałów
    reconstructed_image = cat(3, reconstructed_image_R, reconstructed_image_G, reconstructed_image_B);

    figure; imshow(uint8(reconstructed_image));
    title(['Rekonstrukcja z ', num2str(mv(i)), ' osobliwymi']);
    
    % Obliczenie różnicy między oryginalnym a odtworzonym obrazem
    diff_image = RGB_image - reconstructed_image;
    % Obliczenie średniego błędu
    mean_error = mean(diff_image(:).^2);
    errors(i) = mean_error;
    % Analiza kompresji obrazu
    compression_ratio = numel(S_R) / (numel(U_R) + numel(S_R) + numel(V_R));
    compression_ratios(i) = compression_ratio;
    
    fprintf('Liczba osobliwych: %d, Błąd: %f, Kompresja: %f\n', mv(i), mean_error, compression_ratio);
    input('Naciśnij Enter, aby kontynuować...');
end  % PETLA - STOP

% Wykres zmienności średniego błędu
figure;
plot(mv, errors, 'o-', 'LineWidth', 2);
title('Zmienność średniego błędu w zależności od liczby osobliwych');
xlabel('Liczba osobliwych');
ylabel('Średni błąd rekonstrukcji');
grid on;

% Wykres zmienności stopnia kompresji
figure;
plot(mv, compression_ratios, 'o-', 'LineWidth', 2);
title('Zmienność stopnia kompresji w zależności od liczby osobliwych');
xlabel('Liczba osobliwych');
ylabel('Stopień kompresji');
grid on;
