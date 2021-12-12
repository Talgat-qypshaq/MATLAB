EbNoVec = (0:10)';
EbNoLin = 10.^(EbNoVec/10);
x=sqrt(2*EbNoLin);
fun=@(t)exp(-t.^2);
PARAM2 = x/sqrt(2)
for n=1:11
QFUNC(n) = (0.5)*(1-( (2/sqrt(pi) )*integral(fun, 0, PARAM2(n), 'ArrayValued', true)));
end
semilogy(EbNoVec, QFUNC)
xlabel('Eb/No (dB)')
ylabel('BER')
legend('QPSK')
grid