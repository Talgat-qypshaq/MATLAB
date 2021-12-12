function timeResult = OFDM_CALL(FFT_size, ic)
    %clear;
    %clc;
    timeResult = 0;
    N = 10; %number of users per cluster
    coeffs = [0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.15 0.1];
    Time_signal = zeros(N, FFT_size);
    Tx_carrier_signal = zeros(1,FFT_size);

    for n = 1:N
        for carrier_index = 1:FFT_size
           Tx_carrier_signal(carrier_index) = QPSK_mod(rand(1),rand(1));
        end
        Time_signal(n,:) = sqrt(coeffs(n))*ifft(Tx_carrier_signal, FFT_size).* sqrt(FFT_size);
    end
    
    
    
    
    NOMA_signal = sum(Time_signal);
    %disp(NOMA_signal);
    %disp(Time_signal);
    nvar = 0;

    for time_index = 1:FFT_size %add noise to each sample
        noise =  sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;
        %disp(noise);
        NOMA_signal(time_index) = NOMA_signal(time_index) + noise;%add noise
    end

    if (ic == 'S') %SIC
    tic
        SIC_OFDM(NOMA_signal, N, FFT_size, coeffs);
    timeResult = toc;
    elseif(ic == 'P')%PIC
    tic
        PIC_OFDM(NOMA_signal, N, FFT_size, coeffs);
    timeResult = toc;
    end        
    %fprintf('time %.5f \n', timeResult);
end