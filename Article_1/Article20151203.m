%Same mathematical model applied for n number of users
NumberOfUsers = 3;% please enter number of users/mobile equipments
currentUser = 1;
N=1;    %noise
P = zeros(1, NumberOfUsers);    %power of current user
userForInterference = 1; % variable used to loop through users
PowerMatrixForInterference = zeros(1, NumberOfUsers); %Power of other users e.g. interference
ch=ones(1, NumberOfUsers); %channel matrix
counter=1;
SummsMatrix = zeros(99,1); %Rate of all users
Rate = zeros(99,NumberOfUsers); %Rate or data throughput matrix
clc;
%this loop distributes power for all the users, first user is under
%attention so, his power is 1-beta and the rest of the users share remained
%power equally
for alpha = 0.01:0.01:0.99
    P(1,1) = alpha;
    PowerOfNotFirstUser = (1-P(1,1))/(NumberOfUsers-1); %power of not first user is distributed equally for the rest users
    ChannelOfNotFirstUser = 1;
    %this loop distributes power and channel
    for currentUser = 2:NumberOfUsers
       P(1, currentUser) = PowerOfNotFirstUser;          %allocate power for the rest users
       ChannelOfNotFirstUser = ChannelOfNotFirstUser*10; %increase channel 10 times for the rest users
       ch(1, currentUser) = ChannelOfNotFirstUser;       %allocate channel as described above
    end
    %disp(P);
    %disp(ch);  
    PowerMatrixForInterference(NumberOfUsers) = 0;
    for currentUser = 1:NumberOfUsers         
        %this loop calculates interference e.g. power of other users
        PowerForRateValue = 0;
        for userForInterference = currentUser+1:1:NumberOfUsers
            PowerForRateValue = PowerForRateValue+P(1, userForInterference);                                          
        end
        PowerMatrixForInterference(1, currentUser) = PowerForRateValue;
        %disp(PowerMatrixForInterference);       
        up = P(currentUser)*ch(currentUser)*ch(currentUser);
        down = N+(PowerMatrixForInterference(currentUser)*ch(currentUser)*ch(currentUser));        
        Rate(counter, currentUser) = log2(1+up/down);
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
