x = [];
y = [];
for n = -5 : 0.1 : 5
    x = [x, n];
    y = [y, n.^2 + 1];
end
plot(x,y)
    