function nodes = cheb_nodes(a, b, N)
    k = 0:N;
    theta = ((2 * N + 1) - 2 * k) * pi / (2 * N + 2);
    nodes = cos(theta);
end