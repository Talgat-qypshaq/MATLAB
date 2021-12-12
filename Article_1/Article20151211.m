%Same mathematical model applied for n number of users
NumberOfUsers = 5;% please enter number of users/mobile equipments
currentUser = 1;
N=1;    %noise
userForInterference = 1; % variable used to loop through users
ch=ones(1, NumberOfUsers); %channel matrix
clc;
%this loop distributes power for all the users, first user is under attention,
%so his power is 1-beta and the rest of the users share remained power equally
%NOMA
%read from file
PowerMatrix = dlmread('power5.txt',' ');
rows = size(PowerMatrix, 1);
PowerMatrixForInterference = zeros(rows, NumberOfUsers); %Power of other users e.g. interference
%SummsMatrix = zeros(rows,1); %Overall rate of all users
Rate = zeros(rows, NumberOfUsers+3); %Rate or data throughput matrix
%MinimumRatesValues = zeros(1, NumberOfUsers);
%MinimumRatesIndexes = zeros(1, NumberOfUsers);
%disp(rows);

% row R%TE$

for row = 1:1:rows
    %ChannelOfNotFirstUser = 1;
    %this loop distributes channel   
    channelOfNotFirstUser = 1;    
    for currentUser = NumberOfUsers-1:-1:2
       channelOfNotFirstUser = channelOfNotFirstUser*10;  %increase channel 10 times for the rest users
       ch(1, currentUser) = channelOfNotFirstUser;        %allocate channel as described above
    end
    ch(1, 1) = 3000;
    disp(ch);
    PowerMatrixForInterference(row, NumberOfUsers) = 0; % make zero values of this matrix
    summsMatrix = 0;
    JainsEquationTop = 0;
    JainsEquationBottom = 0;  
    Jain2 = 0;
    Jain = 0;
    for currentUser = 1:NumberOfUsers
        %this loop calculates interference e.g. power of other users
        PowerForRateValue = 0;
        Jain1 = 0;
        if(currentUser>1)
            for userForInterference = currentUser-1:-1:1
                PowerForRateValue = PowerForRateValue+PowerMatrix(row, userForInterference);                                          
            end
        end
        PowerMatrixForInterference(row, currentUser) = PowerForRateValue;
        %This part calculates rate
        up = PowerMatrix(row, currentUser)*ch(currentUser);
        down = N+(PowerMatrixForInterference(row, currentUser)*ch(currentUser));
        Rate(row, currentUser) = log2(1+(up/down));
        summsMatrix = summsMatrix+Rate(row, currentUser);
        %JainsEquationBottom
        if(currentUser<=NumberOfUsers)
            Jain1 = Rate(row, currentUser)*Rate(row, currentUser);
            Jain2 = Jain2+Jain1;
            JainsEquationBottom = NumberOfUsers*Jain2;
%             if (row<=1)
%                 fprintf('Rate of current user %.8f \n', Rate(row, currentUser));
%                 fprintf('Jain1 P %.8f \n', Rate(row, currentUser)*Rate(row, currentUser));
%                 fprintf('Jain1 %.8f \n', Jain1);
%                 fprintf('Jain2 %.8f \n', Jain2);   
%             end
        end
        Rate(row, currentUser+1) = summsMatrix;
        Rate(row, currentUser+2) = min(Rate(row));        
        JainsEquationTop = summsMatrix*summsMatrix;
        Jain = JainsEquationTop/JainsEquationBottom;
        Rate(row, currentUser+3) = Jain;
    end        
end
[MinimumRatesValues, MinimumRatesIndexes] = min(Rate(:,1:5));
%clc;
%disp(PowerMatrixForInterference);     
%disp(Rate);
%[MaxSUM,IndexMaxSum] = max(SummsMatrix);
%[MaxRate,IndexMaxRate] = max(Rate);
%disp('max rate');
%disp([MaxSUM,IndexMaxSum]);
%disp([MaxRate,IndexMaxRate] );
%[MinSumm,IndexMinSumm] = min(SummsMatrix);
%[MinRate,IndexMinRates] = min(Rate);
%disp('min rate');
%disp([MinSumm,IndexMinSumm]);
%disp([MinRate,IndexMinRates]);