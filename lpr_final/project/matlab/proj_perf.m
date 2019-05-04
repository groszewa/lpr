%num bits
N = 1:128

dsc_mul  = 2.^(2*N)
dsc_mac  = 2.^(2*N + 1)

pipe_mul  = 1 + 2.^(N+1)
pipe_mac = 1 + 3*2.^(N)


figure(1)
plot(N,log2(dsc_mul))
hold on
plot(N,log2(pipe_mul))

figure(2)
plot(N,dsc_mac)
hold on
plot(N,pipe_mac)

