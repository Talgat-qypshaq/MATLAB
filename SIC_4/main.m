function [ timeInMS ] = main(group, numberOfUsers, modulation)
cellSize = group*numberOfUsers;
%clc;
%cell size
%set total power in Watts
totalPower = 1;
alpha = dlmread('data/OPA.txt', ' ', [numberOfUsers-5 0 numberOfUsers-5 numberOfUsers-1]);
if (sum(alpha)==0)
    fprintf('there is no optimum power allocation \n');
    return;
end
%disp(alpha);
%set channel array
h = zeros(1, cellSize);
%transmitted signal
if(modulation == 4)
    x = generateQPSK(cellSize);
elseif(modulation == 16)
    x = generateQAM16(cellSize);
elseif(modulation == 64)
    x = generateQAM64(cellSize);
end
%received signal by each UE
y = zeros(1, cellSize);
%decoded signals by each UE
%receivedSignal = zeros(1, cellSize);
%set noise (temporary noise is zero)
n = zeros(1, cellSize);
for noise = 1:1:cellSize
    n(noise, cellSize) = randn*10+1i*randn*10;
end
%transmitted signal with power coefficient
signalWithPowerCoefficient = zeros(1, cellSize);
%generate channel array for each user
for i=1:1:cellSize
    order = mod(i, numberOfUsers);
    if(order == 0)
        order = numberOfUsers;
    end
    powerCoefficientRatio = alpha(1, order);
    %set channel of ith user
    h(1, i) = RayleighChannel(powerCoefficientRatio);
    %set transmitted signal with power coefficient
    signalWithPowerCoefficient(1, i) = x(1, i)*sqrt(alpha(1, order)*totalPower);
end
superSignal = sum(signalWithPowerCoefficient);
%set received signal of ith user
for i=1:1:cellSize    
    y(1,i) = superSignal*h(1, i)+n(1, i);
end
tic
%for i=1:1:cellSize 
    %[receivedSignal(1,1)] = SIC(cellSize, alpha, h(1,i), y(1,i), i, modulation);
    SIC(cellSize, alpha, h(1,i), y(1,i), modulation);
    %fprintf('Received signal %.10f \n', receivedSignal(1,i));
%end
%fileID = fopen('data6/HP_SIC_MATLAB.txt','w');
elapsedTime = toc;
timeInMS = elapsedTime*1000;
%fprintf('overall SIC time: %.16f \n', timeInMS );
end