x = 1 + 1i; % signal to transmit
TRIAL = 2*10^6; %number of simulation runs
for EbN0 = 0:1:20
nvar = 0.5/(10^(EbN0/10)); %calculation of noise variaence
error = 0;%set error counter to 0
for trial = 1:TRIAL
%h = (randn(2,TRIAL)+1i*randn(2,TRIAL));
%Rayleigh channel
h1 = sqrt(0.25)*(randn+1i*randn);
h2 = sqrt(0.25)*(randn+1i*randn);
%generate AWGN noise with certain varience.
n1 = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;
n2 = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;
y1 = x*h1 + n1;
y2 = x*h2 + n2;
y=(y1*conj(h1)+y2*conj(h2));
if (real(y) < 0)
%define decision region on I quadrature
    error = error + 1;
%if real part of the signal is out of decision region increment error counter by 1
end
if (imag(y) < 0)
%if imaginary part of the signal is out of decision region increment error counter by 1
    error = error + 1;
end
end
%calculate BER by dividing number of error bits to total number of transmitted bits
BER(EbN0+1) = error/(2*TRIAL); 
end
EbNo=0:1:20;
% plot BER vs EbNo
semilogy(EbNo,BER,'r');
grid on; box on;
xlabel('EbNo(dB)')%Label for x-axis
ylabel('Bit error rate') %Label for y-axis
legend('BER performance of QPSK modulation in Rayleigh channels');
hold on
