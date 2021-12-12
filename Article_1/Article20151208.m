%Same mathematical model applied for n number of users
NumberOfUsers = 5;% please enter number of users/mobile equipments
currentUser = 1;
N=1;    %noise
%P = zeros(1, NumberOfUsers);    %power of current user
userForInterference = 1; % variable used to loop through users
ch=ones(1, NumberOfUsers); %channel matrix
clc;
%this loop distributes power for all the users, first user is under
%attention so, his power is 1-beta and the rest of the users share remained
%power equally
%NOMA
%read from file
PowerMatrix = dlmread('power5.txt',' ');
rows = size(PowerMatrix, 1);
PowerMatrixForInterference = zeros(rows, NumberOfUsers); %Power of other users e.g. interference
SummsMatrix = zeros(rows,1); %Overall rate of all users
Rate = zeros(rows, NumberOfUsers); %Rate or data throughput matrix
%disp(rows);
for row = 1:1:rows
    %ChannelOfNotFirstUser = 1;
    %this loop distributes channel   
    channelOfNotFirstUser = 1;    
    for currentUser = 2:1:NumberOfUsers
       channelOfNotFirstUser = channelOfNotFirstUser*10;  %increase channel 10 times for the rest users
       ch(1, currentUser) = channelOfNotFirstUser;        %allocate channel as described above
    end
    %disp(ch);  
    PowerMatrixForInterference(row, NumberOfUsers) = 0; % make zero values of this matrix
    summsMatrix = 0;
    for currentUser = 1:NumberOfUsers         
        %this loop calculates interference e.g. power of other users
        PowerForRateValue = 0;
        for userForInterference = currentUser+1:1:NumberOfUsers
            PowerForRateValue = PowerForRateValue+PowerMatrix(row, userForInterference);                                          
        end
        PowerMatrixForInterference(row, currentUser) = PowerForRateValue;          
        %This part calculates rate
        up = PowerMatrix(row, currentUser)*ch(currentUser);
        down = N+(PowerMatrixForInterference(row, currentUser)*ch(currentUser));        
%         fprintf('------------------START-----------------\n');
%         fprintf('row %d, currentUser %d \n', row, currentUser);
%         fprintf('Power of current user %.5f \n', PowerMatrix(row, currentUser));
%         fprintf('Channel of current user %d \n', ch(currentUser));
%         fprintf('Interference of current user %.5f \n', PowerMatrixForInterference(row, currentUser));
%         fprintf('up %.5f \n', up);
%         fprintf('down %.5f \n', down);
%         fprintf('------------------END-------------------\n');
        Rate(row, currentUser) = log2(1+(up/down));
        summsMatrix = summsMatrix+Rate(row, currentUser);
        SummsMatrix(row, 1) = summsMatrix;
    end        
end
%clc;
%disp(PowerMatrixForInterference);     
%disp(Rate);
%disp(SummsMatrix);
[MaxSUM,IndexMaxSum] = max(SummsMatrix);
[MaxRate,IndexMaxRate] = max(Rate);
%disp('max rate');
%disp([MaxSUM,IndexMaxSum]);
%disp([MaxRate,IndexMaxRate] );
[MinSumm,IndexMinSumm] = min(SummsMatrix);
[MinRate,IndexMinRates] = min(Rate);
%disp('min rate');
%disp([MinSumm,IndexMinSumm]);
%disp([MinRate,IndexMinRates]);