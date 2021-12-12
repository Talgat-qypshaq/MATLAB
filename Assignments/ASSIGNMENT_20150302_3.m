x = 1+1i;
for EbNo=0:10
    noise_varience = 0.5/(10^(EbNo/10));
    BER_counter=0;
    for N = 1:10^6   
        noise = sqrt(noise_varience)*(randn +1i*randn);
        y = x+noise;
        if (real(y)<0)
            BER_counter = BER_counter+1;
        end
        if (imag(y)<0)
            BER_counter = BER_counter+1;
        end
    end
    BER(EbNo+1)=BER_counter/N;
end
EbNo=0:10;
semilogy(EbNo, BER)
xlabel('Eb/No (dB)')
ylabel('BER')
legend('QPSK')
grid
