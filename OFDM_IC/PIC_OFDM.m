%%% Decodes all UEs with PIC at BS
function [] = PIC_OFDM(signal, num_iter, FFT_size, coeffs)
    %NOMA_signal = signal;    
    NOMA_signal = zeros(num_iter, FFT_size);
    bits_carrier = zeros(FFT_size, 2);
    Tx_carrier_signal = zeros(1, FFT_size);
    Time_signal = zeros(num_iter, FFT_size);
    Rx_carrier_signal_2 = zeros(num_iter, FFT_size);
    sqrtFFT = sqrt(FFT_size);
%     timeFFT_1 = 0;
%     timeFFT_2 = 0;
%     timeiFFT = 0;
%     timeDecoding_1 = 0;
%     timeDecoding_2 = 0;
%     timeModulation = 0;
%     timeSubtract = 0;
%     timeSum = 0;
    for iter = 1:1:num_iter %num_iter = number of UEs    
       % tic
            %% FFT operation
            Rx_carrier_signal = fft(signal,FFT_size)./sqrtFFT;
            %disp(Rx_carrier_signal);    
       % timeFFT_1 = timeFFT_1+toc;
      %  tic
            %% ML decoding for each subcarrier
            for carrier_index = 1:FFT_size 
                bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index)); %% ML
            end
%        timeDecoding_1 = timeDecoding_1+toc;
      %  tic
            for carrier_index = 1:FFT_size
                Tx_carrier_signal(carrier_index) = QPSK_mod(bits_carrier(carrier_index,1),bits_carrier(carrier_index,2));
            end
       % timeModulation = timeModulation+toc;      
        num_iter_UE = mod(num_iter, 10);
        if (num_iter_UE==0)
            num_iter_UE=10;
        end        
        iter_UE = mod(iter, 10);
        if (iter_UE==0)
            iter_UE=10;
        end   
       % tic
            %fprintf('num_iter_UE =  %d; iter_UE = %d; iter = %d; ', num_iter_UE, iter_UE, iter);
            %fprintf('num_iter_UE =  %.2f \n', coeffs(num_iter_UE - iter_UE+1));        
            Time_signal(iter,:) = sqrt(coeffs(num_iter_UE - iter_UE+1))*ifft(Tx_carrier_signal, FFT_size ) .* sqrtFFT;
       % timeiFFT = timeiFFT+toc;
    end    
%  tic
%   timeSum = timeSum+toc;    
%   tic
    % NEW PIC ITERATION CODE FOR ALL users START
    summ = sum(Time_signal(1:num_iter, :));
    %disp(summ);
    for ue = 1:1:num_iter
        %disp(summ_1);
        NOMA_signal(ue, :) = signal - summ + Time_signal(ue, :);
        %disp(NOMA_signal);
        %for FFT = 1:1:FFT_size            
        %    NOMA_signal(ue, FFT) = signal(FFT) - sum(Time_signal(1:num_iter, FFT)) + Time_signal(ue, FFT);
            %Rx_carrier_signal_2(iter, FFT) = fft(NOMA_signal(iter, 1:FFT_size),FFT_size)./sqrtFFT;
            %disp(fft(NOMA_signal(iter, 1:FFT_size),FFT_size)./sqrtFFT);
        %end                    
        Rx_carrier_signal_2(ue, :) = fft(NOMA_signal(ue, :),FFT_size)./sqrtFFT;
            %disp(Rx_carrier_signal);
        for c = 1:FFT_size
            %fprintf('decoding: user index =  %d fft index =  %d \n', iter, carrier_index); 
            %fprintf('sending the signal: real =  %.2f imag =  %.2f \n', real(Rx_carrier_signal_2(carrier_index)), imag(Rx_carrier_signal_2(carrier_index)));        
            bits_carrier(c,:) = QPSK_decode(Rx_carrier_signal_2(ue, c));
            %QPSK_decode(Rx_carrier_signal_2(carrier_index));
            %disp(bits_carrier(c,:));
        end
    end
    % NEW PIC ITERATION CODE FOR ALL users END
%     for a = 1:1:num_iter
%         for b = 1:FFT_size
%         %fprintf('decoding: user index =  %d fft index =  %d \n', iter, carrier_index); 
%         %fprintf('sending the signal: real =  %.2f imag =  %.2f \n', real(Rx_carrier_signal_2(carrier_index)), imag(Rx_carrier_signal_2(carrier_index)));        
%         bits_carrier(b,:) = QPSK_decode(Rx_carrier_signal_2(a, b));
%         %QPSK_decode(Rx_carrier_signal_2(carrier_index));
%         %disp(bits_carrier(carrier_index,:));
%         end
%     end
    %disp(NOMA_signal);
    %disp(NOMA_signal);
  %  timeSubtract = timeSubtract+toc;
    %disp(NOMA_signal);
  %  tic
    %Rx_carrier_signal = fft(NOMA_signal,FFT_size)./sqrt(FFT_size);    
%     timeFFT_2 = timeFFT_2+toc;
    
%     tic
    %for carrier_index = 1:FFT_size 
        %bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index));
        %disp(bits_carrier(carrier_index,:));
    %end
%     timeDecoding_2 = timeDecoding_2+toc;
    %convert to ms
%     timeFFT_1 = timeFFT_1*1000;
%     timeFFT_2 = timeFFT_2*1000;
%     timeiFFT = timeiFFT*1000;
%     timeDecoding_1 = timeDecoding_1*1000;
%     timeDecoding_2 = timeDecoding_2*1000;
%     timeModulation = timeModulation*1000;
%     timeSum = timeSum*1000;
%     timeSubtract = timeSubtract*1000;
    %fprintf('timeFFT_1 =  %.2f; timeFFT_2 = %.2f; timeiFFT = %.2f; \n', timeFFT_1, timeFFT_2, timeiFFT);
    %fprintf('timeDecoding_1 = %.2f; timeModulation = %.2f; timeSum = %.2f; timeSubtract = %.2f; timeDecoding_2 = %.2f; \n', timeDecoding_1, timeModulation, timeSum, timeSubtract, timeDecoding_2 );
end

%for all UEs
%     for iter = 1:1:num_iter
%         N_signal = signal - sum(Time_signal(1:num_iter-1,FFT_size));
%         Rx_carrier_signal = fft(N_signal,FFT_size)./sqrt(FFT_size);
%         for carrier_index = 1:FFT_size 
%             bits_carrier(carrier_index,:) = QPSK_decode(Rx_carrier_signal(carrier_index)); %% ML
%             %disp(bits_carrier(carrier_index,:));
%         end    
%     end    