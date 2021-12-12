function [ x ] = SIC(powerCoefficients, channel, receivedSignal, modulation)
% STEP 1. decode the stronger signal
% (assuming power coefficients are ordered and assigned in the correct order)
% implement SIC, subtract decoded stronger signal from received signal
numberOfUsers = size(powerCoefficients, 2);
x = zeros(1, numberOfUsers);
signalPowerCoefficientChannel = zeros(1, numberOfUsers);
       
    for i = numberOfUsers:-1:1
        if(i == numberOfUsers)
            x(1, i) = receivedSignal/(channel*powerCoefficients(1, numberOfUsers));
        else
            x(1, i) = (receivedSignal - sum(signalPowerCoefficientChannel))/(channel*powerCoefficients(1, i));
        end
        %decode x
        RealPart = real(x(1, i));
        ImagPart = imag(x(1, i));
        %fprintf('Real = %s ', num2str(RealPart));
        %fprintf('Imag = %s \n', num2str(ImagPart));
        %end
        if(modulation == 4)
            [RealPart, ImagPart] = DecodeRealAndImageQPSK(RealPart, ImagPart);
        elseif(modulation == 16)
            [RealPart, ImagPart] = DecodeRealAndImageQAM(RealPart, ImagPart);
        elseif(modulation == 64)
            [RealPart, ImagPart] = DecodeRealAndImageQAM64(RealPart, ImagPart);
        end
        %decoded x
        x(1, i) = RealPart+ImagPart*1i;
        if(i ~= 1)
            signalPowerCoefficientChannel(1, i) = x(1, i)*powerCoefficients(1,i)*channel;
        end                
        %rr = real(x(1, i));            
        %ii = imag(x(1, i));
        %fprintf('Real = %s ', num2str(rr));
        %fprintf('Imag = %s \n', num2str(ii));
        %fprintf('%d SIC signal %.10f \n', i, x(1,i));            
    end

end