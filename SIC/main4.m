function [ errorBit ] = main4(ratio)
%clc;
%set total power in Watts
totalPower = 1;
numberOfUsers = 13;
%PowerAllocation(numberOfUsers);
%alpha = OptimumPowerAllocation(numberOfUsers, fairnessConstraint);
%alpha = dlmread('data/OPA.txt', ' ', [numberOfUsers-5 0 numberOfUsers-5 numberOfUsers-1]);
fileName = strcat('data2/', num2str(ratio));
fileName = strcat(fileName,'.txt');
%disp(fileName);
alpha = dlmread(fileName, ' ');
if (sum(alpha)==0)
    fprintf('there is no optimum power allocation \n');
    return;
end
%alpha = dlmread('data/power6.txt', ' ', [0 0 0 numberOfUsers-1]);
%disp(alpha);
%set channel array
h = zeros(1, numberOfUsers);
%transmitted signal
x = generateQPSK(numberOfUsers);
%received signal by each UE
y = zeros(1, numberOfUsers);
%decoded signals by each UE
receivedSignal = zeros(1, zeros);
%set noise (temporary noise is zero)
n = zeros(1,numberOfUsers);
%transmitted signal with power coefficient
signalWithPowerCoefficient = zeros(1, numberOfUsers);
%generate channel array for each user
for i=1:1:numberOfUsers
    powerCoefficientRatio = alpha(1, i);
    %set channel of ith user
    h(1, i) = RayleighChannel(powerCoefficientRatio);
    %set transmitted signal with power coefficient
    signalWithPowerCoefficient(1, i) = x(1, i)*sqrt(alpha(1, i)*totalPower);
end
superSignal = sum(signalWithPowerCoefficient);
%set received signal of ith user
for i=1:1:numberOfUsers    
    y(1,i) = superSignal*h(1, i)+n(1, i);
end
counter = 0;
errorBit = 0;
for i=1:1:numberOfUsers
    [receivedSignal(1,i), timeSIC] = SIC(alpha, h(1,i), y(1,i), i);
    if(i==1)
        SICUEFirst = timeSIC;
    end
    if(i==numberOfUsers)
        SICUELAST = timeSIC;
    end
    if(receivedSignal(1,i) == x(1, i))
        counter = counter + 1;
    else
        receivedRealPart = real(receivedSignal(1, i));
        receivedImagPart = imag(receivedSignal(1, i));
        sentRealPart = real(x(1, i));
        sentImagPart = imag(x(1, i));
        if (receivedRealPart ~= sentRealPart)
            errorBit = errorBit + 1;
        end
        if (receivedImagPart~=sentImagPart)
            errorBit = errorBit + 1;
        end
    end
end

fprintf('SIC %.16f \n', SICUEFirst); 
fprintf('SIC %.16f \n', SICUELAST);

%disp(x);
%disp(y);
%disp(receivedSignal);
%fprintf('%s matches out of %s \n', num2str(counter), num2str(numberOfUsers));
%fprintf('%s bit errors out of %s \n', num2str(errorBit), num2str((numberOfUsers-counter)*2));
end