function [ transmittedSignal, timeSIC ] = SIC( powerCoefficients, channel, receivedSignal, whichUser, modulation )
% STEP 1. check whether whichUser is lower or equal to size of power coefficients array
tic;
numberOfUsers = size(powerCoefficients, 2);
if (whichUser>numberOfUsers)
    transmittedSignal = 0;
else
% STEP 2. decode the stronger signal
% (assuming power coefficients are ordered and assigned in the correct order)
% implement SIC, subtract decoded stronger signal from received signal
x = zeros(1, numberOfUsers);
signalPowerCoefficientChannel = zeros(1, numberOfUsers);
for i = numberOfUsers:-1:whichUser
    if(i == numberOfUsers)
        x(1, i) = receivedSignal/(channel*powerCoefficients(1, i));
    else
        x(1, i) = (receivedSignal - sum(signalPowerCoefficientChannel))/(channel*powerCoefficients(1, i));
    end
    %decode x
    RealPart = real(x(1, i));
    ImagPart = imag(x(1, i));
    %if(whichUser==12 || whichUser==13)
    %   disp(RealPart);
    %   disp(ImagPart);
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
    if(i ~= whichUser)
        signalPowerCoefficientChannel(1, i) = x(1, i)*powerCoefficients(1,i)*channel;
    end
end
timeSIC = toc;
transmittedSignal = x(1, whichUser);
end
end