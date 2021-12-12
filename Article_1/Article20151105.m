%Same mathematical model applied for n number of users
NumberOfUsers = 3; % please enter number of users/mobile equipments
currentUser = 1;
N=1;    %noise
P = zeros(1, NumberOfUsers);    %power of current user
%Power=1;
%PowerSumm = 0;
%PowerMatrix = zeros(1, NumberOfUsers);
PowerSummsMatrix = zeros(99,1);
PowerMatrixForRate = zeros(1, NumberOfUsers);
PowerForRateVariable = 0;
userForPower=1;
ch=ones(1, NumberOfUsers);
counter=1;
%RatesMatrix = zeros(99,NumberOfUsers);
SummsMatrix = zeros(99,1);
%Rate = 0:0.01:1;
Rate = zeros(99,NumberOfUsers);
clc;
%this loop distributes power for all the users, first user is under
%attention so, his power is 1-beta and the rest of the users share remained
%power equally
for alpha = 0.01:0.01:0.99
    P(1,1) = alpha;
    %PowerSumm = P(1,1);
    %PowerMatrix(1,1) = P(1,1);
    PowerOfNotFirstUser = (1-P(1,1))/(NumberOfUsers-1);
    ChannelOfNotFirstUser = 1;
    for currentUser = 2:NumberOfUsers
        P(1, currentUser) = PowerOfNotFirstUser;
        ChannelOfNotFirstUser = ChannelOfNotFirstUser*10;
        ch(1, currentUser) = ChannelOfNotFirstUser;      
        %PowerMatrix(1, currentUser) = PowerOfNotFirstUser;  
        %PowerSumm = PowerSumm+P(1,currentUser);                     
    end
    %disp(P);
    %disp(ch);
    PowerForRateValue = 0;
    for userForPower=NumberOfUsers-1:-1:1        
        PowerForRateValue = PowerForRateValue+P(1, userForPower+1);
        PowerMatrixForRate(1, userForPower) = PowerForRateValue;                              
    end
    %disp(PowerMatrixForRate);    
    %PowerMatrixForRate(NumberOfUsers) = 0;
    for currentUser = 1:NumberOfUsers  
        up = P(currentUser)*ch(currentUser)*ch(currentUser);
        down = N+(PowerMatrixForRate(currentUser)*ch(currentUser)*ch(currentUser));        
        Rate(counter, currentUser) = log2(1+up/down);
        %Rate(counter, currentUser) = log2(1+((P(currentUser)*ch(currentUser)*ch(currentUser))/N+(PowerMatrixForRate(currentUser)*ch(currentUser)*ch(currentUser))));    
        SummsMatrix(counter, 1) = SummsMatrix(counter, 1)+Rate(counter, currentUser);
    end
    counter = counter+1;
end
%clc;
%disp(Rate);
%disp(SummsMatrix);
[MaxSUM,IndexMaxSum] = max(SummsMatrix);
[MaxRate,IndexMaxRate] = max(Rate);
disp('max rate');
disp([MaxSUM,IndexMaxSum]);
disp([MaxRate,IndexMaxRate] );

[MinSumm,IndexMinSumm] = min(SummsMatrix);
[MinRate,IndexMinRates] = min(Rate);
disp('min rate');
disp([MinSumm,IndexMinSumm]);
disp([MinRate,IndexMinRates] );

%plot(R1, R2, 'B');
%hold on
%grid on; box on;
%xlabel('Rate of user 1') %Label for x-axis
%ylabel('Rate of user 2') %Label for y-axis
%legend('NOMA');
%hold on 
