function [  ] = SIC( cellSize, powerCoefficients, channel, receivedSignal, modulation )
    % STEP 1. check whether whichUser is lower or equal to size of power coefficients array
    %tic;
    numberOfUsers = size(powerCoefficients, 2);
    x = zeros(1, cellSize);
    signalPowerCoefficientChannel = zeros(1, cellSize);
    order = mod(cellSize, numberOfUsers);
    if(order == 0)
        order = numberOfUsers;
    end
    % STEP 2. decode the stronger signal
    % (assuming power coefficients are ordered and assigned in the correct order)
    % implement SIC, subtract decoded stronger signal from received signal
    for i = cellSize:-1:1
        if(i == cellSize)
            x(1, i) = receivedSignal/(channel*powerCoefficients(1, 10));
        else
            x(1, i) = (receivedSignal - sum(signalPowerCoefficientChannel))/(channel*powerCoefficients(1, order));
        end
        %decode x
        RealPart = real(x(1, i));
        ImagPart = imag(x(1, i));
        %if(whichUser==12 || whichUser==13)
        %fprintf('i: %d\n', i);
        %fprintf('%.5f %.5fi\n', RealPart, ImagPart);
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
            signalPowerCoefficientChannel(1, i) = x(1, i)*powerCoefficients(1,order)*channel;
        end
        %transmittedSignal = x(1, whichUser);
    end
    %timeSIC = toc;
    %disp(transmittedSignal );
end