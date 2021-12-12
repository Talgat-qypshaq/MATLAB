clear;
clc;
% signal to transmit
x1 = 1 + 1i;
x2 = 1 - 1i;

EbN0 = 3;
%calculation of noise variaence
nvar = 0;%10^(-8); %in 1 GHz bandwdidth for noise density = 10^-17 W/Hz                      

%user 1 (closer) rayleigh channel and noise
g1 = 10^(-3.3); %-33 dB
n1 = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;

%user 2 rayleigh channel and noise
g2 = 10^(-3.6); %-36 dB
n2 = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;

%superimposed transmitted signal
alpha1 = 0.5;
alpha2 = 0.5;
x = x1*alpha1 + x2*alpha2;  %where k1 and k2 are power coefficients

%received signal by user 1
y1 = x*h1 + n1;

%received signal by user 2
y2 = x*h2 + n2;

%closer user 1, no SIC
x1_decoded = y1/h1;

%far user with SIC
x2_decoded = y2/h2;
