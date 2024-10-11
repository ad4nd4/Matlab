clear all; close all;

% multiplikatywny (ile liczb, pierwsza liczba)
r_mult = rand_mult(10000,123);

% generator kongruentny
r_multadd = rand_multadd(10000,123);

% okresy
okres_mult = find_period(r_mult);
okres_multadd = find_period(r_multadd);

disp(['Okres multiplikatywny: ', num2str(okres_mult)]);
disp(['Okres kongruentny: ', num2str(okres_multadd)]);

figure; plot(r_mult,'bo');
title('Generator multiplikatywny');
figure; plot(r_multadd,'ro');


% histogram
figure; 
subplot(2,1,1);
hist(r_mult,20);
title('Histogram - Generator multiplikatywny');

subplot(2,1,2);
hist(r_multadd,20);
title('Histogram - Generator kongruentny');

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

%##############################
function s=rand_mult( N, seed )
    a = 69069;
    p = 2^12;
    s = zeros(N,1);
    for k=1:N
        s(k) = mod(seed*a,p);
        seed = s(k);
    end
    s = s/p;
end
%#################################
function s=rand_multadd( N, seed )
    a = 69069;
    m = 5;
    p = 2^32;

%microsoft visual
    %a = 214013; 
    %m = 2531011;
    %p = 2^32;
    %s = zeros(N,1);

    for k=1:N
        s(k) = mod(seed*a+m,p);
        seed = s(k);
    end

    s = s/p;
end

