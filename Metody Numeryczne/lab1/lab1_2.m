a = 1;
b = 4;
c = 4;

delta = b^2 - 4 * a * c;

if delta > 0

    p1 = (-b + sqrt(delta)) / (2 * a);
    p2 = (-b - sqrt(delta)) / (2 * a);
    fprintf('M. zerowe: x1 = %.2f, x2 = %.2f\n', p1, p2);

    if a*p1^2 + b*p1 + c == 0
        
        fprintf('p1 jest prawidłowe\n');
    else
        fprintf('x1 nie jest prawidłowe\n');
    end

    if a*x2^2 + b*x2 + c == 0
        fprintf('x2 jest prawidłowe\n');
    else
        fprintf('x2 nie jest prawidłowe\n');
    end

elseif delta == 0
              
    p1 = -b / (2 * a);

    fprintf('M. zerowe (jedno): x1 = %.2f\n', p1);

    if a*p1^2 + b*p1 + c == 0
        
        fprintf('x1 jest prawidłowe\n');
    else
        fprintf('x1 nie jest prawidłowe\n');
    end

else
    fprintf('Brak miejsc zerowych w dziedzinie liczb rzeczywistych.\n');
end