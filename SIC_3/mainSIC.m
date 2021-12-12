function [timeInMS] = mainSIC(numberOfUsers, modulation)
    %clc;
    %set total power in Watts
    totalPower = 1;
    %set channel array
    h = zeros(1, numberOfUsers);
    %transmitted signal
    x = generateQPSK(numberOfUsers);
    %received signal by each UE
    y = zeros(1, numberOfUsers);
    %decoded signals by each UE
    %decodedMessage = zeros(1, zeros);
    %transmitted signal with power coefficient
    signalWithPowerCoefficient = zeros(1, numberOfUsers);
    %set noise (temporary noise is zero), power and generate channel array for each user
    n = zeros(1, numberOfUsers);
    power = zeros(1,numberOfUsers);
    for a=1:1:numberOfUsers
        n(a, numberOfUsers) = randn*10+1i*randn*10;
        power(1,a) = 1/numberOfUsers;
        h(1, a) = RayleighChannel(power(1,a));
        signalWithPowerCoefficient(1, a) = x(1, a)*sqrt(power(1, a)*totalPower);
    end
    superSignal = sum(signalWithPowerCoefficient);
    %set received signal of ith user
    for i=1:1:numberOfUsers
        y(1,i) = superSignal*h(1, i)+n(1, i);
    end
    tic
        %for i=1:1:numberOfUsers
            i = 1;
            SIC(power, h(1,i), y(1,i), i, modulation);
        %end
    elapsedTime = toc;
    timeInMS = elapsedTime*1000;
    %fprintf('overall SIC time: %.9f seconds \n', elapsedTime);
    %clear;    
end