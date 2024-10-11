function H = Entropy(x)
    xu = unique(x);
    p = [];
    for i = 1:length(xu)
        p(end+1) = sum(x == xu(i)) / length(x);
    end
    xu, p
    H = -1 * sum(p.*log2(p));
end