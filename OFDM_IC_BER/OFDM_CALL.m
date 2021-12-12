% function [] = OFDM_CALL(
clear;
clc;

numberOftrials = 1000;

numberOfUEs = 2;
FFT_size = 64;
%coefficients are taken from AICT conference work result
%coeffs = [0.01 0.05 0.12 0.28 0.54];
coeffs = [0.01 0.05 0.12 0.28 0.54];

noisePower = 0; %dBm;

noiseLinear = 10^((noisePower-30)/10);

Time_signal = zeros(numberOfUEs, FFT_size);
messageRaw = zeros(FFT_size, 1);
messagesArray = zeros(numberOfUEs, FFT_size);

for n = 1:numberOfUEs
%     generate messages        
    for carrier_index = 1:FFT_size
        randomSignal = rand(1)+rand(1)*1j;
%         fprintf('random signal = %.2f %.2fj\n', real(randomSignal), imag(randomSignal));
        messagesArray(n, carrier_index) = QPSK_mod(randomSignal);
%         fprintf('modulated message = %.2f %.2fj\n', real(MessageRaw(carrier_index)), imag(MessageRaw(carrier_index)));
        messageRaw(carrier_index) = messagesArray(n, carrier_index);
    end        
    Time_signal(n,:) = sqrt(coeffs(n))*ifft(messageRaw, FFT_size).* sqrt(FFT_size);
end
signal = sum(Time_signal);

for signalPower = 0:1:50 % dBm
    
    Powerlinear = 10^((signalPower-30)/10);
    signal_pow = mean(abs(signal).^2);
    signalP = sqrt(1/signal_pow)*signal*sqrt(Powerlinear);

    errorU = zeros(numberOfUEs,1); 
    for t = 1:1:numberOftrials        
        %add noise
        signal_noise = signalP + sqrt(noiseLinear)*randn(1,FFT_size) + j*sqrt(noiseLinear)*randn(1,FFT_size);
        messageDecoded = PIC_OFDM(signal_noise, numberOfUEs, FFT_size, coeffs);   
               
        for n = 1:numberOfUEs                
             for carrier_index = 1:FFT_size
                 if(real(messageDecoded(n,carrier_index)) - real(messagesArray(n, carrier_index)) ~= 0)
                     errorU(n) = errorU(n) + 1;
                 end

                 if(imag(messageDecoded(n,carrier_index)) - imag(messagesArray(n, carrier_index)) ~= 0)
                     errorU(n) = errorU(n) + 1;
                 end
             end                          
        end      
    end
        errorU = errorU ./ (FFT_size*4*numberOftrials);    
        error(signalPower+1,:) = errorU ;
    
end

%plot user k
k = 1;
semilogy(error(:,1))
hold on
semilogy(error(:,2),'r')