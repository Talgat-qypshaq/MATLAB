function [timeInMS ] = userGroupMain(numberOfGroups, numberOfUsers, modulation)
%clc;
%cell size
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
h = zeros(numberOfGroups, numberOfUsers);
%disp(modulation);
%transmitted signal
if(modulation == 4)
    x = generateQPSK(numberOfGroups, numberOfUsers);
elseif(modulation == 16)
    x = generateQAM16(numberOfGroups, numberOfUsers);
elseif(modulation == 64)
    x = generateQAM64(numberOfGroups, numberOfUsers);
end
% for ng=1:1:numberOfGroups
%     for nu=1:1:numberOfUsers
%        fprintf('%d generated signal %.10f \n', ng*nu, x(ng, nu));
%     end
% end

%received signal by each UE
y = zeros(numberOfGroups, numberOfUsers);
%set noise (temporary noise is zero)
n = zeros(numberOfGroups, numberOfUsers);
for noiseI = 1:1:numberOfGroups
    for noiseJ = 1:1:numberOfUsers
        n(noiseI, noiseJ) = randn*10+1i*randn*10;
    end
end
%transmitted signal with power coefficient
signalWithPowerCoefficient = zeros(numberOfGroups, numberOfUsers);
%generate channel array for each user

for i = 1:1:numberOfGroups
    for j = 1:1:numberOfUsers
        powerCoefficientRatio = alpha(1, j);
        %set channel of ith user
        h(i, j) = RayleighChannel(powerCoefficientRatio);
        %set transmitted signal with power coefficient
        signalWithPowerCoefficient(i, j) = x(i, j)*sqrt(alpha(1, j)*totalPower);
    end
end

superSignal = sum(signalWithPowerCoefficient);

%set received signal of ith user
for g = 1:1:numberOfGroups
    for u = 1:1:numberOfUsers    
        y(g,u) = superSignal(1, u)*h(g, u)+n(g, u);
    end
end
tic
    for i=1:1:numberOfGroups        
        SIC(alpha, h(i,numberOfUsers), y(i, numberOfUsers), modulation);            
    end
elapsedTime = toc;
%fileID = fopen('data6/HP_SIC_MATLAB.txt','w');
timeInMS = elapsedTime*1000;
%fprintf('overall SIC time in ms: %.16f \n', timeInMS );
end