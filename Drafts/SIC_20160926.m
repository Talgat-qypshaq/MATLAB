function [] = SIC_20160926(numberOfUsers, fairnessConstraint)
%SIC_20160926
clc;
PowerAllocation(numberOfUsers);
alpha = OptimumPowerAllocation(numberOfUsers, fairnessConstraint);
if (sum(alpha)==0)
    fprintf('there is no optimum power allocation \n');
    return;
end
%alpha = dlmread('data/power6.txt', ' ', [0 0 0 numberOfUsers-1]);
disp(alpha);
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
    powerCoefficientRatio = alpha(1, i)/alpha(1,1);
    %set channel of ith user
    h(1, i) = RayleighChannel2(powerCoefficientRatio);
    %set transmitted signal with power coefficient
    signalWithPowerCoefficient(1, i) = x(1, i)*alpha(1, i);
end
superSignal = sum(signalWithPowerCoefficient);
%set received signal of ith user
for i=1:1:numberOfUsers    
    y(1,i) = superSignal*h(1, i)+n(1, i);
end
counter = 0;
for i=1:1:numberOfUsers
    receivedSignal(1,i) = SIC(alpha, h(1,i), y(1,i), i);
    if(receivedSignal(1,i) == x(1, i))
        counter = counter + 1;
    end
end

disp(x);
disp(y);
disp(receivedSignal);
fprintf('%s matches out of %s \n', num2str(counter), num2str(numberOfUsers));
end