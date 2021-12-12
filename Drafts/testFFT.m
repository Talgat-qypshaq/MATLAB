clear all;
clc;
%--------------------------------------------------------
FFT_size = 8192; %number of symbols
%-----------------simulation parameters -----------------
N = 10; %number of users
coeffs = [0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.15 0.1];
%--------------------------------------------------------
Tx_carrier_signal = zeros(FFT_size, 1);
Time_signal = ones(N, FFT_size);
%for n = 1:N
    for carrier_index = 1:FFT_size
       Tx_carrier_signal(carrier_index) = QPSK_mod(rand(1),rand(1));
    end
    %disp(Tx_carrier_signal);
    %Time_signal(n,:) = sqrt(coeffs(n))*ifft(Tx_carrier_signal, FFT_size).*sqrt(FFT_size);
    %Time_signal(n, :) = 5.*3;
%end
tic
ifft(Tx_carrier_signal, 8192);
toc