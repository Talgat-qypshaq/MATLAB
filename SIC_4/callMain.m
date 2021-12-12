function [] = callMain(groups, numberOfUsers)
    clc;    
    modulation = 64;  
    for a=1:1:20
        for i=2:-1:1
            timeInMS = 0;   
            %for j = 1:1:10000
                timeInMS = timeInMS+main(groups, numberOfUsers, modulation);
            %end
            %timeInMS = timeInMS/1000;
            if(timeInMS<3.7 && timeInMS>3.2)
                fprintf('without user grouping: %d-QAM modulation SIC time: %.3f ms \n', modulation, timeInMS );
            end
            modulation  = modulation/4;
        end
        modulation = 64;
        fprintf('new \n');
    end
    %averageTime = timeInMS/numberOfIterations;
    %fprintf('average SIC time for %d iterations and %d modulation is : %.16f ms \n', numberOfIterations, modulation, averageTime );
end