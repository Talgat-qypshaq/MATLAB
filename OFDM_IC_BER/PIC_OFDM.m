%%% Decodes all UEs with PIC at BS

function [messageDecoded] = PIC_OFDM(signal, numberOfUEs, FFT_size, coeffs)
    messageDecoded = zeros(numberOfUEs, FFT_size);
    Tx_carrier_signal = zeros(1, FFT_size);
    Time_signal = zeros(numberOfUEs, FFT_size);
    
    for iter = 1:1:numberOfUEs %num_iter = number of UEs    
        %% FFT operation
        Rx_carrier_signal = fft(signal,FFT_size)./sqrt(FFT_size);
        %disp(Rx_carrier_signal);    
        %% ML decoding for each subcarrier
        for carrier_index = 1:FFT_size 
            Tx_carrier_signal(carrier_index) = QPSK_mod(QPSK_decode(Rx_carrier_signal(carrier_index)));
        end
        Time_signal(iter,:) = sqrt(coeffs(iter))*ifft(Tx_carrier_signal, FFT_size ) .* sqrt(FFT_size);
    end
    
    summed_signal = sum(Time_signal);
            
    for a = 1:numberOfUEs
        NOMA_signal = signal - summed_signal + Time_signal(a,:) ;       

        Rx_carrier_signal = (1/sqrt(coeffs(iter)))*fft(NOMA_signal,FFT_size)./sqrt(FFT_size);      
       
        for carrier_index = 1:FFT_size
            messageDecoded(a, carrier_index) = QPSK_decode(Rx_carrier_signal(carrier_index));        
        end
    end
    
end

