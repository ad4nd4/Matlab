[Y, X] = meshgrid(0.1:0.1:28, 0.1:0.1:16);

axis([0, 16, 0, 28]);

line([0, 10], [20.05, 20.05]);
line([13, 16], [20.05, 20.05]);

fctr = 0.7;
x_tx = 12.05;
y_tx = 7.05;
c = 3 * 10^8;
f = 3.6;
P = 10*log10(5);
lambda = c / f;

power = zeros(160, 280);

for x=1:160
    for y=1:280
        dist = sqrt((x_tx - x/10)^2 + (y_tx - y/10)^2);
        FSL = 32.44 + 20*log10(dist) + 20*log10(f);

        wall1 = dwawektory(0, 20.05, 10, 20.05, x_tx, y_tx, x/10, y/10);
        wall2 = dwawektory(13, 20.05, 16, 20.05, x_tx, y_tx, x/10, y/10);

        if wall1 == -1 && wall2 == -1
            power(x, y) = P - FSL;
        else
            power(x, y) = -100;
        end
    end
end

pcolor(X, Y, power);
shading("interp");
colorbar;