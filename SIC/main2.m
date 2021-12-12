%this function is to implement SIC and calculate SIC for each UE in the
%network
function [] = main2(numberOfUsers)
%clc;
%set total power in Watts
totalPower = 1;
fileName = strcat('data2/', num2str(numberOfUsers));
fileName = strcat(fileName,'.txt');
%disp(fileName);
alpha = dlmread(fileName, ' ');
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
n = zeros(1,numberOfUsers);
for noise=1:1:numberOfUsers
    n(noise, numberOfUsers) = randn*0.001+1j*randn*1;
end
interf = zeros(1,numberOfUsers);
interf(noise, 12) = randn*10+1j*randn*10;
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
    y(1,i) = superSignal*h(1, i)+n(1, i)+interf(1, i);
end
%SIC time for all UEs
SICTime = zeros(1,numberOfUsers);
% modulation = 4 for QPSK
% modulation = 16 for 16-QAM
% modulation = 64 for 64-QAM
modulation = 4;
for i=1:1:numberOfUsers
    [receivedSignal(1,i), timeSIC] = SIC(alpha, h(1,i), y(1,i), i, modulation);
    SICTime(1, i) = timeSIC;
end
for i=1:1:numberOfUsers
    fprintf('SIC TIME %.16f \n', SICTime(1, i));
end
end