x = 1 + 1i; % signal to transmit
TRIAL = 2*10^6; %number of simulation runs
for EbN0 = 0:1:20
nvar = 0.5/(10^(EbN0/10));%calculation of noise variaence
error = 0;%set error counter to 0
for trial = 1:TRIAL
%h = (randn(2,TRIAL)+1i*randn(2,TRIAL));
h = sqrt(0.5)*(randn+1i*randn); %Rayleigh channel
n = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;%generate AWGN noise with certain varience.
y = x*(h) + n;
y = y/h;
if (real(y) < 0)%define decision region on I quadrature
    error = error + 1;%if real part of the signal is out of decision region increment error counter by 1
end
if (imag(y) < 0)%if imaginary part of the signal is out of decision region increment error counter by 1
    error = error + 1;
end
end
BER(EbN0+1) = error/(2*TRIAL);%calculate BER by dividing number of error bits to total number of transmitted bits
end
EbNo=0:1:20;
semilogy(EbNo,BER,'r');% plot BER vs EbNo
grid on; box on;
xlabel('EbNo(dB)')%Label for x-axis
ylabel('Bit error rate') %Label for y-axis
hold on