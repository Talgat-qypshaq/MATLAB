function [ SICUEFirst, SICUELAST] = main(numberOfUsers, modulation)
%clc;
%set total power in Watts
totalPower = 1;
%PowerAllocation(numberOfUsers);
alpha = dlmread('data/OPA.txt', ' ', [numberOfUsers-5 0 numberOfUsers-5 numberOfUsers-1]);
%alpha = dlmread('data2/44.txt', ' ');
if (sum(alpha)==0)
    fprintf('there is no optimum power allocation \n');
    return;
end
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
n = zeros(1, numberOfUsers);
for noise=1:1:numberOfUsers
    n(noise, numberOfUsers) = randn*10+1i*randn*10;
end
%transmitted signal with power coefficient
signalWithPowerCoefficient = zeros(1, numberOfUsers);
%generate channel array for each user
for i=1:1:numberOfUsers
    powerCoefficientRatio = alpha(1, i);
    %set channel of ith user
    h(1, i) = RayleighChannel(powerCoefficientRatio);
    %set transmitted signal with power coefficient
    %signalWithPowerCoefficient(1, i) = x(1, i)*alpha(1, i);
    signalWithPowerCoefficient(1, i) = x(1, i)*sqrt(alpha(1, i)*totalPower);
end
superSignal = sum(signalWithPowerCoefficient);
%set received signal of ith user
for i=1:1:numberOfUsers
    y(1,i) = superSignal*h(1, i)+n(1, i);
end
counter = 0;
errorBit = 0;
fileID = fopen('data_plot/data9/ACER_SIC_MATLAB.txt','w');
tic
    for i=1:1:numberOfUsers
        [receivedSignal(1,i), timeSIC] = SIC(alpha, h(1,i), y(1,i), i, modulation);
        %fprintf('SIC %d %.16f \n', i, timeSIC);
        timeSIC = timeSIC*1000;
        if(i==numberOfUsers)
            fprintf(fileID, '%.16f', timeSIC);    
        else
            fprintf(fileID, '%.16f ', timeSIC);
        end
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
elapsedTime = toc;
fprintf('overall SIC time: %.16f \n', elapsedTime*1000);
%dlmwrite('myFile.txt',M,'delimiter','\t','precision',3)
%fprintf('SIC %.16f \n', SICUEFirst); 
%fprintf('SIC %.16f \n', SICUELAST);

%disp(x);
%disp(y);
%disp(receivedSignal);
%fprintf('%s matches out of %s \n', num2str(counter), num2str(numberOfUsers));
%fprintf('%s bit errors out of %s \n', num2str(errorBit), num2str((numberOfUsers-counter)*2));
end