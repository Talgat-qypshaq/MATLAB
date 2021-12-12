function [] = PIC(power, channel, signal, numberOfUsers, modulation)
    
    estimated_signal = zeros(1,numberOfUsers);
    estimated_message = zeros(1,numberOfUsers);
    decoded_signals = zeros(1,numberOfUsers);
    %decoded_symbols = zeros(1,numberOfUsers);
    
    for i=1:1:numberOfUsers
        estimated_signal(1,i) = signal/(channel(1,i)*power(1,i));
        %fprintf('estimated signal 1 %.4f + %.4fi \n', real(estimated_signal(1,i)), imag(estimated_signal(1,i)) );
        if(modulation == 4)
            decoded_signals(1,i) = decodeQAM(real(estimated_signal(1,i)), imag(estimated_signal(1,i)));
        elseif(modulation == 16)
            decoded_signals(1,i) = decodeQAM(real(estimated_signal(1,i)), imag(estimated_signal(1,i)));
        end
        %fprintf('decoded signal 1 %.4f + %.4fi \n', real(decoded_signal(1,i)), imag(decoded_signal(1,i)) );
    end
    
    %fprintf('\n');
    
    sum_decoded = sum(decoded_signals);
    sum_channel = sum(channel);
    sum_power = (power);
    
    for j=1:1:numberOfUsers        
        estimated_message(1,j) = ( (signal(1,1)/(sum_channel(1,1)*sum_power(1,1)) ) - sum_decoded(1,1)+decoded_signals(1,j));
        %fprintf('estimated message 2 %.4f + %.4fi \n', real(estimated_message(1,j)), imag(estimated_message(1,j)) );
        if(modulation == 4)
            decodeQAM( real(estimated_message(1,j)), imag(estimated_message(1,j)) );
        elseif(modulation == 16)
            decodeQAM( real(estimated_message(1,j)), imag(estimated_message(1,j)) );
        end
    end

end