M = 3;
w = 1:M;
N = M+(M-1);
p = rand(1,N);
y = conv(p,w);

for m = 0:M-1
    P(1+m, 1:M) = p(M+m : -1 : 1+m);