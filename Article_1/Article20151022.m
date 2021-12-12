alpha1=0.5;
alpha2=0.5;
TRIAL = 1000;
h1=1;
h2=1;
for EbN0=0:1:10
nvar=0.5/10^(EbN0/10);
error1=0;
error2=0;
    for trial = 1:TRIAL    
    data1=round(rand(1)); %data
    data2=round(rand(1)); %data
    x1=2*data1-1; %bpsk
    x2=2*data2-1; %bpsk
    x=alpha1*x1+alpha2*x2;
    %before data is transmitted make sure power is normalized
    %n = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn; %AWGN    
    n=0;
    y1=x*h1+n; %received signal
    y2=x*h2+n;
    
    %BER for the first user     
    if (y1>0)
        d_est1=1;
    else
        d_est1=0;
    end
    if(d_est1~=data1)
        error1 = error1 + 1;
    end
    %BER for the second user     
    if (y2>0)
        d_est2=1;
    else
        d_est2=0;
    end
    if(d_est2~=data2)
        error2 = error2 + 1;
    end
    
    end
BER1(EbN0+1)=error1/(TRIAL);
BER2(EbN0+1)=error2/(TRIAL);
end
EbNo=0:1:10;
plot(BER1, 'G');
hold on
plot(BER2, 'R');
hold on
grid on; 
box on;
xlabel('EbNo(dB)')%Label for x-axis
ylabel('Bit error rate') %Label for y-axis
hold on