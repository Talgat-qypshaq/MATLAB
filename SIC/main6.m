function [SICTime] = main6(numberOfUsers, numberOfTrials, runCase, modulation)
clc;
%set total power in Watts
totalPower = 1;
fileName = strcat('data2/', num2str(numberOfUsers));
fileName = strcat(fileName,'.txt');
alpha = dlmread(fileName, ' ');
if (sum(alpha)==0)
    fprintf('there is no optimum power allocation \n');
    return;
end
%set channel array
h = zeros(1, numberOfUsers);
if(modulation == 4)
    %transmitted QPSK signal
    x = generateQPSK(numberOfUsers);
elseif(modulation==16)
    %transmitted QAM signal
    x = generateQAM(numberOfUsers);
elseif(modulation==64)
    x = generateQAM64(numberOfUsers);
else
    error('Modulation can be 4, 16 or 64');
end
%received signal by each UE without interference
y = zeros(1, numberOfUsers);
%received signal by each UE with interference
%yInterference = zeros(1, numberOfUsers);
%decoded signals by each UE
receivedSignal = zeros(1, zeros);
%set noise (temporary noise is zero)
noise = zeros(1, numberOfUsers);
%interference = zeros(1, numberOfUsers);
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
% counter = 0;
% errorBit = 0;
UEs = zeros(1, numberOfUsers);
time = zeros(numberOfUsers, 1);
for trial = 1:1:numberOfTrials
    for i=1:1:numberOfUsers
        noise(1, i) = randn*0.001+1j*randn*0.001;    
%         if (i==12)
%             interference(1, i) = randn*10+1j*randn*10;
%         end
        y(1,i) = superSignal*h(1, i)+noise(1, i);
        %correct order
        if (runCase == 1)
            [receivedSignal(1,i), SICTime] = SIC(alpha, h(1,i), y(1,i), i, modulation);
        end
        %imperfect order
        if(runCase == 2)
            if(i<12)
                newI = i+(randi(3)-1);
                [receivedSignal(1,i), SICTime] = SIC(alpha, h(1,i), y(1,i), newI, modulation);
            end
            if(i>11)
                [receivedSignal(1,i), SICTime] = SIC(alpha, h(1,i), y(1,i), i, modulation);            
            end
        end
        %[receivedSignal(1,i), SICTime] = SIC(alpha, h(1,i), y(1,i), newI);
        %yInterference(1,i) = superSignal*h(1, i)+noise(1, i)+interference(1, i);
        %[receivedSignal(1,i), SICTime] = SIC(alpha, h(1,i), yInterference(1,i), i);
        UEs(1, i) = i;       
        time(i, 1) = SICTime;
    end
end
time = time./numberOfTrials;
if(runCase==1)
    timeCase1 = time;
    save('timeCase1.mat');
end
if(runCase==2)
    timeCase2 = time;
    save('timeCase2.mat');
end
hold on
p = plot(UEs, time, 'LineWidth', 2, 'markers', 12 );
set(gca,'box','on')
%xlim([minimumNumberOfUEs-1 maximumNumberOfUEs+1]);
p(1).Marker = '*';
xlabel('UEs')
ylabel('Time (seconds)')
%legend('Incorrect order of UEs decode', 'Correct order of UEs decode', 'Sum of two computations');
%legend('Correct order of UEs decode');
end