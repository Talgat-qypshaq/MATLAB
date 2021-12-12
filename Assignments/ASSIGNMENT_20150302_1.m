% SOLUTION 1
EbNo = (0:10)';                             % 11 x 1 error bit vector
M = 4;                                      % Modulation order 4 is selected
BER = berawgn(EbNo,'psk',M,'nondiff');      % psk - modulation scheme, nondiff - nondifferential data encoding
semilogy(EbNo,BER)                          % lines 5-9 to draw a graph
xlabel('Eb/No (dB)')
ylabel('BER')
legend('QPSK')
grid