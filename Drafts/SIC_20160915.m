clear;
clc;
%TRIAL = 2*10^6; %number of simulation runs
TRIAL = 2;
% signal to transmit
x1 = 1 + 1i;
x2 = 1 - 1i;
for EbN0 = 1:1:1
%calculation of noise variaence
nvar = 0.5/(10^(EbN0/10));                      
for trial = 1:TRIAL
%generate AWGN noise with certain varience
n = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;
% condition of SIC h2>h1, UE 2 has the better channel and performs SIC
% in a simulations we set distances of transmitter from the receiver as 
% 300 m (UE1) and 100 m (UE2), therefore channel coefficients are in ratio 3:1 
% UE 2 has a better channel than UE 1 and hence can decode any data that UE 1 can successfully decode.
% Rayleigh channel
h1 = sqrt(0.5)*(randn+1i*randn);
% as a sample te channel for UE2 is 3 times stronger, since it is 3 times
% closer to transmitter
h2 = 3*h1;
%Received signal
y = x1*h1+x2*h2+n;
% decoding of received y1. Receiver is aware of h1, therefore it will
% clearly identify the required data. The rest data (x2h2 and n) both is
% considered as noise
y1 = x1*h1+(x2*h2+n)-(x2*h2+n);
% data of UE1
yd1 = x1*h1/h1+(x2*h2+n)-(x2*h2+n);
% decoding of received y2 signal 
% 1. decoding of UE 1 signal: x1+(x2*h2+n)/h1;
% 2. subtract transmitted signal from y
y2 = y - y1 - n;
% data of UE2
yd2 = y2/h2;
%fprintf( '%s \n' , num2str(z) )
fprintf('x1 %s \n', num2str(x1));
fprintf('x2 %s \n', num2str(x2));

fprintf('h1 %s \n', num2str(h1));
fprintf('h2 %s \n', num2str(h2));

fprintf('n %s \n', num2str(n));

fprintf('y1 %s \n', num2str(y1));
fprintf('y2 %s \n', num2str(y2));
%finally we obtain sent data
fprintf('yd1 %s \n', num2str(yd1));
fprintf('yd2 %s \n', num2str(yd2));
end
end



