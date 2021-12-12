function [] = Algorithm(numberOfUsers)
clc;
n = numberOfUsers;
%powerMatrix = zeros(rows, n);
rows = 1;
powerMatrix = zeros(rows, n);
powerSize = 1;
powerStart = 0.01;
%summPrevious = 0;
fprintf('number of users %d \n', n);
coefficientBosmushe (1, n) = zeros;
coefficient (1, n) = zeros;
for h=1:1:rows
flag = n-1;
sumCoefficientBosmushe = 0;
sumCoefficient = 0;
flagCounter = 1;
fprintf('flag %d \n', flag);
powerMatrix(h,1) = powerStart;
% solve equation and put flag
    summTilFlag = 0;
    for i=1:1:n        
        if (i>1)            
            sum = 0;
            for j=1:1:i-1
                sum = sum + powerMatrix(h,j);                
            end
            powerMatrix(h,i) = sum+0.01;
        end           
        if(i==n)
            powerMatrix(h,i) = powerSize-sum;
        end
        if (i<flag)
            summTilFlag = summTilFlag+powerMatrix(h,i);
        end
        if(i>=flag)       
                fprintf('flagCounter %d \n', flagCounter);
                if (flagCounter==1)
                    coefficient(h,flagCounter) = 0.01;
                    coefficientBosmushe(h,flagCounter) = 0;
                end
                if (flagCounter==2)
                    coefficient(h,flagCounter) = 0.01;
                    coefficientBosmushe(h,flagCounter) = summTilFlag+0.01;
                end
                if (flagCounter>2)
                    coefficient(flagCounter) = coefficient(flagCounter-1)*2;
                    coefficientBosmushe(flagCounter) = coefficientBosmushe(flagCounter-1)*2;
                end
            flagCounter = flagCounter+1;
        end
    end
    for f=1:1:flagCounter                
        sumCoefficientBosmushe = sumCoefficientBosmushe+coefficientBosmushe(f);
        sumCoefficient = sumCoefficient+coefficient(f);
    end
    %maximumFlag = (100-sumCoefficientBosmushe)./sumCoefficient;
    leftPower = 1-(sumCoefficientBosmushe+summTilFlag);
    C = fix(leftPower/sumCoefficient);
    %fprintf('sumCoefficientBosmushe %d \n', sumCoefficientBosmushe);
    %fprintf('sumCoefficient %d \n', sumCoefficient);
    %fprintf('C %d \n', C);
    disp(sumCoefficientBosmushe);
    disp(sumCoefficient);
    disp(C);
    %fprintf('summTilFlag %d \n', summTilFlag);
    disp(summTilFlag);
end
disp(powerMatrix);