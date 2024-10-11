srand_custom(uint32(now)); % Ustawienie seed na aktualny czas
rand_numbers = zeros(1, 10000);

for n = 1:10000
    rand_numbers(n) = rand_custom();
end

%wyniki
figure;
plot(rand_numbers);
title('Wykres - Generator rand()');

%statystyki
mean_value = mean(rand_numbers);
disp(['Średnia wartość: ', num2str(mean_value)]);

%okres
period = find_period(rand_numbers);
disp(['Okres: ', num2str(period)]);

function result = rand_custom()
    persistent next;
    
    if isempty(next)
        next = 1;
    end
    
    next = mod(next * 1103515245 + 12345, 2^31);
    result = floor(mod(next / 65536, 32768));
end

function srand_custom(seed)
    global next;
    next = seed;
end

function okres = find_period(sequence)
    N = length(sequence);
    for k = 1:N
        if isequal(sequence(1:N-k), sequence(k+1:N))
            okres = k;
            return;
        end
    end
    okres = 0;
end