function [] = callMain(numberOfGroups, numberOfUsers)    
    clc;
    modulation = 64;       
    for i=3:-1:1
        timeInMS = 0;    
        %for j = 1:1:10000
            timeInMS = timeInMS+userGroupMain(numberOfGroups, numberOfUsers, modulation);
        %end
        %timeInMS = timeInMS/10000;
        fprintf('with user grouping %d-QAM modulation SIC time: %.16f ms \n', modulation, timeInMS );            
        modulation  = modulation/4;
    end
    %averageTime = timeInMS/numberOfIterations;
    %fprintf('average SIC time for %d iterations and %d modulation is : %.16f ms \n', numberOfIterations, modulation, averageTime );
end