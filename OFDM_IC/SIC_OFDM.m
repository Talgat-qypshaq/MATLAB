%%% Decodes all UEs with SIC at BS
function [] = SIC_OFDM(signal, num_iter, FFT_size, coeffs)
    NOMA_signal = signal;
    bits_carrier = zeros(FFT_size, 2);
    Tx_carrier_signal = zeros(1, FFT_size);
    
    %timeFFT = 0;
    %timeiFFT = 0;
    %timeDecoding_1 = 0;
    %timeDecoding_2 = 0;
    %timeModulation = 0;
    %timeSubtract = 0;
    
    for iter = num_iter:-1:1 %sequential
        %tic
        %% FFT operation
        Rx_carrier_signal = fft(NOMA_signal,FFT_size)./sqrt(FFT_size);
        %disp(Rx_carrier_signal);    
        %timeFFT = timeFFT+toc;        
        %tic
        %% ML decoding for each subcarrier
        for carrier_index = 1:FFT_size 
            bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index)); %% ML
        end
        %timeDecoding_1 = timeDecoding_1+toc;
        if(iter ~= 1)
            %tic
                for carrier_index = 1:FFT_size
                   Tx_carrier_signal(carrier_index) = QPSK_mod(bits_carrier(carrier_index,1),bits_carrier(carrier_index,2));
                end
            %timeModulation = timeModulation+toc;
            %disp(bits_carrier);%disp(Tx_carrier_signal);
            num_iter_UE = mod(num_iter, 10);
            if (num_iter_UE==0)
                num_iter_UE=10;
            end        
            iter_UE = mod(iter, 10);
            if (iter_UE==0)
                iter_UE=10;
            end
            %fprintf('num_iter_UE =  %d; iter_UE = %d; iter = %d; ', num_iter_UE, iter_UE, iter);
            %fprintf('num_iter_UE =  %.2f \n', coeffs(num_iter_UE - iter_UE+1));
            %tic
                Time_signal = sqrt(coeffs(num_iter_UE - iter_UE+1))*ifft(Tx_carrier_signal, FFT_size ) .* sqrt(FFT_size);                      
            %timeiFFT = timeiFFT+toc; 
            %tic
                NOMA_signal = NOMA_signal - Time_signal;                    
            %timeSubtract = timeSubtract+toc;
        end
    end
    %tic
    %Rx_carrier_signal = fft(NOMA_signal,FFT_size)./sqrt(FFT_size);
    %timeFFt_2 = timeFFt_2+toc;
    %tic
        for carrier_index = 1:FFT_size 
            bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index));
            %disp(bits_carrier(carrier_index,:));
        end
    %timeDecoding_2 = timeDecoding_2+toc;
    %convert to ms
%     timeFFT = timeFFT*1000;    
%     timeiFFT = timeiFFT*1000;    
%     timeDecoding_1 = timeDecoding_1*1000;
%     timeDecoding_2 = timeDecoding_2*1000;
%     timeModulation = timeModulation*1000;    
%     timeSubtract = timeSubtract*1000;
%    fprintf('timeFFT =  %.2f; timeiFFT =  %.2f; \n', timeFFT, timeiFFT);
%    fprintf('timeDecoding_1 = %.2f; timeModulation = %.2f; timeSubtract = %.2f; timeDecoding_2 = %.2f;\n', timeDecoding_1, timeModulation, timeSubtract, timeDecoding_2 );
end