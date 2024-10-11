clear all; close all;

hold on;

for n = 4:10
    i = (0 : n)';
    xi = cos(2 * pi / n * i);
    yi = sin(2 * pi / n * i);
    
    disp(['For n = ' num2str(n)]);
    disp([i, xi, yi]);

    X = vander(i);
  
    ax = X \ xi;
    ay = X \ yi;
    %wart dokladne
    id = 0 : 0.01 : n;
    xd = cos(2 * pi / n * id);
    yd = sin(2 * pi / n * id);

    plot(xi, yi, 'ko', xd, yd, 'r--', polyval(ax, id), polyval(ay, id), 'b.-');
end

xlabel('x'); ylabel('y'); title('y=f(x)'); axis square; grid; axis equal;

figure;
plot(i, xi, 'ko', id, xd, 'r--', id, polyval(ax, id), 'b.-');
xlabel('i'); ylabel('x'); title('x=f(i)'); grid; axis equal;
