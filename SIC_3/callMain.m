function [] = callMain()
    clc;    
    modulation = 16;
    %UEs = [10 100 500 1000 1500 2000];
    UEs = [1000 1000 1000 1000 1000 1000];
    for a=1:1:6
        for i=2:-1:1
            timeInMS = 0;   
            %for j = 1:1:10000
            numberOfUsers = UEs(a);
            fprintf('%d \n', numberOfUsers);
                timeInMS = timeInMS+mainSIC(numberOfUsers, modulation);
            %end
            %timeInMS = timeInMS/1000;
            if(timeInMS<3.5 && timeInMS>2.8)
                fprintf('%d-QAM modulation SIC time: %.3f ms \n', modulation, timeInMS );
            end
            modulation  = modulation/4;
        end
        modulation = 16;        
    end
    %averageTime = timeInMS/numberOfIterations;
    %fprintf('average SIC time for %d iterations and %d modulation is : %.16f ms \n', numberOfIterations, modulation, averageTime );
end