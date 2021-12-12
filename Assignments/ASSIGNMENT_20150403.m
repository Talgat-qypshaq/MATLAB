TRIAL = 2*10^6;
FFT_S=64;
for m=1:FFT_S
    x(m)=1+1i;
end
% initiate 4 matrixes of zeros
n=zeros(1,FFT_S);
y_t=zeros(1,FFT_S);
y=zeros(1,FFT_S);
AVG_ERROR=zeros(1,11);

for EbN0 = 0:10
nvar = 0.5/(10^(EbN0/10));%calculation of noise variaence
error = 0;
    for trial = 1:TRIAL
         for k=1:FFT_S
             n(k) = sqrt(nvar)*randn + 1j*sqrt(nvar)*randn;%generate AWGN noise with varience.
             y_t(k) = ifft(x(k)) + n(k);
             y(k)=fft(y_t(k));
         if (real(y(k)) < 0)
             error = error + 1;
         end         
         if (imag(y(k)) < 0)
             error = error + 1;
             end
         end
    AVG_ERROR(EbN0+1)=error/64;% Average BER  
    end
BER(EbN0+1) = AVG_ERROR(EbN0+1)/(2*TRIAL);%calculate BER by dividing number of error bits to total number of transmitted bits
end
EbNo=0:10;
semilogy(EbNo,BER,'r');
grid on; box on;
xlabel('EbNo(dB)')
ylabel('Bit error rate')
hold on