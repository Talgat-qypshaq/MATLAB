function [] = SIC_OFDM(signal, num_iter, FFT_size, coeffs)
    NOMA_signal = signal;
    bits_carrier = zeros(FFT_size, 2);
    Tx_carrier_signal = zeros(1, FFT_size);
    
    
        
    for iter = num_iter:-1:1 %sequential
        %% FFT operation
        Rx_carrier_signal = fft(NOMA_signal,FFT_size)./sqrt(FFT_size);
        %disp(Rx_carrier_signal);    
        %% ML decoding for each subcarrier
        for carrier_index = 1:FFT_size 
            bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index)); %% ML
        end    
        %disp(bits_carrier);
        if(iter ~= 1)
            for carrier_index = 1:FFT_size
               Tx_carrier_signal(carrier_index) = QPSK_mod(bits_carrier(carrier_index,1),bits_carrier(carrier_index,2));
            end
            %disp(bits_carrier);
            %disp(Tx_carrier_signal);
            Time_signal = sqrt(coeffs(num_iter - iter+1))*ifft(Tx_carrier_signal, FFT_size ) .* sqrt(FFT_size);                
            NOMA_signal = NOMA_signal - Time_signal;        
        end                
    end
    
    Rx_carrier_signal = fft(NOMA_signal,FFT_size)./sqrt(FFT_size);
    for carrier_index = 1:FFT_size 
        bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index));
        %disp(bits_carrier(carrier_index,:));
    end