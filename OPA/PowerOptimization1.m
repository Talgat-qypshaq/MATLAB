numberOfUsers = 13;
overallPower = 100;
powerArray = zeros(1, numberOfUsers);
clc;
for power = 1:1:overallPower
    powerOfLastUser = 0;
    powerOfAllUsersExceptLast = 0;    
    for currentUser = 1:1:(numberOfUsers-1)
        powerArray(1, currentUser) = power-1+currentUser;
        powerOfAllUsersExceptLast = powerOfAllUsersExceptLast+powerArray(1, currentUser);
        powerOfLastUser = overallPower-powerOfAllUsersExceptLast;
        if(powerOfLastUser<=powerArray(1, currentUser))
            disp('break 1');
            break;
        end        
    end
    if(powerOfLastUser <= powerArray(1, numberOfUsers-1))
        disp('break 2');
        break;
    end
    powerArray(1, numberOfUsers) = overallPower - powerOfAllUsersExceptLast;
    disp(powerArray); 
end