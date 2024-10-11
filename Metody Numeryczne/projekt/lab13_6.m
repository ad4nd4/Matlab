function y = generate_prbs_9()

    N = 9;
    feedback_taps = [9, 5];
    buf = ones(1, N);

    y = zeros(1, 2^N - 1);
    for n = 1:length(y)
        y(n) = buf(end);

        y_n = xor(buf(feedback_taps(1)), buf(feedback_taps(2)));

        buf = circshift(buf, [0, 1]);
        buf(1) = y_n;
    end
end


