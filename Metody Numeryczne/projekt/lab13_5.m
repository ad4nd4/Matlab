function PRBS
    for N = 2:12
        L = (2^N) - 1;
        buf = ones(1, N);
        y = zeros(1, L);

        for n = 1:L
            if (N == 2)
                y(n) = xor(buf(1), buf(2));
            elseif (N == 3)
                y(n) = xor(buf(2), buf(3));
            elseif (N == 4)
                y(n) = xor(buf(3), buf(4));
            elseif (N == 5)
                y(n) = xor(buf(3), buf(5));
            elseif (N == 6)
                y(n) = xor(buf(5), buf(6));
            elseif (N == 7)
                y(n) = xor(buf(4), buf(7));
            elseif (N == 8)
                y(n) = xor(buf(4), xor(buf(5), xor(buf(6), buf(8))));
            elseif (N == 9)
                y(n) = xor(buf(5), buf(9));
            elseif (N == 10)
                y(n) = xor(buf(7), buf(10));
            elseif (N == 11)
                y(n) = xor(buf(9), buf(11));
            elseif (N == 12)
                y(n) = xor(buf(6), xor(buf(8), xor(buf(11), buf(12))));
            end

            buf = [y(n) buf(1:N-1)];
        end

        figure;
        subplot(211);
        stem(y, 'bo');
        title(['y(n) dla N=', num2str(N)]);
        subplot(212);
        stem(-L+1:L-1, xcorr(y - mean(y)));
        grid;
        title(['Ryy(k) dla N = ', num2str(N)]);
        axis tight;
        pause;
    end
end
%N  Odczepy oktalnie   Odczepy binarnie
%--------------------------------------
%2          7                       111
%3         13                      1011
%4         23                     10011
%5         45                    100101
%6        103                   1000011
%7        211                  10001001
%8        435                 100011101
%9       1021                1111111001
%10      2011               10000001001
%11      4005              100000000101
%12     10123             1000001010011
