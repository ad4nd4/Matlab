fs = 8000;  % Częstotliwość próbkowania
T = 0.5;    % Czas trwania jednego dźwięku w sekundach
dt = 1/fs;  % Czas pomiędzy próbkami
N = round(T/dt);  % Liczba próbek na jeden dźwięk
t = dt * (0:N-1); % Wejście czasowe dla jednego dźwięku
damp = exp(-t/(T/2));  % Funkcja tłumienia eksponencjalnego

keys = {'1','2','3','4','5','6','7','8','9','0','w','e','r','t','y','u','i','o','p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l',';', 'z','x','c'};
freq = [fkm(3,1),fkm(3,3),fkm(3,6),fkm(3,8),fkm(3,10),fkm(4,1),fkm(4,3),fkm(4,6),fkm(4,8),fkm(4,10),...
        fkm(3,0), fkm(3,2), fkm(3,4), fkm(3,5), fkm(3,7), fkm(3,9), fkm(3,11), fkm(4,0), ...
        fkm(4,2), fkm(4,4), fkm(4,5), fkm(4,7), fkm(4,9), fkm(4,11), fkm(5,0), ...
        fkm(5,2), fkm(5,4), fkm(5,5), fkm(5,7), fkm(5,9), fkm(5,11), fkm(6,0)];

disp('Press keys to play notes. Press q to quit.');

while true
    w = waitforbuttonpress;
    key = get(gcf, 'CurrentCharacter');
    
    %exit
    if key == 'q'
        break;
    end
    
    %szukanie dzwieku po wcisnieciu klawisza
    idx = find(strcmp(keys, key));
    
    if ~isempty(idx)
        %generowanie i odtwarzanie
        x = damp .* sin(2*pi*freq(idx)*t);
        
        sound(x, fs);
    end
end

function fk = fk(k)
    fk = 2^k * 27.5;
end

function fkm = fkm(k, m)
    fkm = fk(k) * 2^(m/12);
end