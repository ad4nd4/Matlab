x1 = (1 + 1/4) * 2^(-124);
x2 = -5.877472 * 10^(-38);

areEqual = isequal(single(x1), single(x2));

if areEqual
    disp('Reprezentacje binarne x1 i x2 są takie same.');
else
    disp('Reprezentacje binarne x1 i x2 są różne.');
end





