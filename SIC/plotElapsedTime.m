function [ ] = plotElapsedTime( minimumNumberOfUEs, maximumNumberOfUEs, numberOfTrials )
clc;
if ( (minimumNumberOfUEs <= 2) || (maximumNumberOfUEs >= 14) )
    fprintf('minimum number of UEs should be more than 2 \n');
    fprintf('maximum number of UEs should be less than 14 \n');
else
    UEs = zeros(1, maximumNumberOfUEs-minimumNumberOfUEs+1);
    time = zeros(maximumNumberOfUEs-minimumNumberOfUEs+1, 2);
    for trial = 1:1:numberOfTrials
        for numberOfUEs = minimumNumberOfUEs:1:maximumNumberOfUEs
            [SICUEFirst, SICUELAST] = main2(numberOfUEs);                
            UEs(1, numberOfUEs-minimumNumberOfUEs+1) = numberOfUEs;
            %time(numberOfUEs-minimumNumberOfUEs+1, 1) = SICUEFirst;
            %time(numberOfUEs-minimumNumberOfUEs+1, 2) = SICUELAST;
            time(numberOfUEs-minimumNumberOfUEs+1, 1) = time(numberOfUEs-minimumNumberOfUEs+1, 1)+SICUEFirst;
            time(numberOfUEs-minimumNumberOfUEs+1, 2) = time(numberOfUEs-minimumNumberOfUEs+1, 2)+SICUELAST;
        end                            
    end
    %disp(time);
    time = time./numberOfTrials;
    %disp(time);
    %disp(size(time));
    %disp(size(UEs));
    p = plot(UEs, time, 'LineWidth', 2 );
    xlim([minimumNumberOfUEs-1 maximumNumberOfUEs+1]);
    p(1).Marker = 'o';
    p(2).Marker = 'x';
    
    xlabel('UEs')
    ylabel('Time (seconds)')
    legend('First UE', 'Last UE');
end