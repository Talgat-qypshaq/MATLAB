x = 1 + j; % signal to transmit (qpsk)
TRIAL = 2*10^6; %number of simulation runs
for EbN0 = 0:1:10
nvar = 0.5/(10^(EbN0/10));  %calculation of noise variaence
error = 0;%set error counter to 0
for trial = 1:TRIAL
n = sqrt(nvar)*randn + j*sqrt(nvar)*randn;%generate AWGN noise with certain varience.
disp(n)
%disp(n);
y = x + n;
if (real(y) < 0)%define decision region on I quadrature
error = error + 1;%if real part of the signal is out of decision region increment error counter by 1
end
if (imag(y) < 0)%if imaginary part of the signal is out of decision region increment error counter by 1
error = error + 1;
end
end
BER(EbN0+1) = error/(2*TRIAL);%calculate BER by dividing number of error bits to total number of transmitted bits
end
EbNo=0:1:10
semilogy(EbNo,BER,'r');% plot BER vs EbNo
grid on; box on;
xlabel('EbNo(dB)')%Label for x-axis
ylabel('Bit error rate') %Label for y-axis
hold on
theoryBER=0.5*erfc(sqrt(power(10,0.1*EbNo)));%theoretical BER function defined by MATLAB
plot(EbNo,theoryBER,'b');