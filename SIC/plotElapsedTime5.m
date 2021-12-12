function [ ] = plotElapsedTime5( minimumNumberOfUEs, maximumNumberOfUEs, numberOfTrials )
clc;
if ( (minimumNumberOfUEs <= 2) || (maximumNumberOfUEs >= 14) )
    fprintf('minimum number of UEs should be more than 2 \n');
    fprintf('maximum number of UEs should be less than 14 \n');
else
    UEs = zeros(1, maximumNumberOfUEs-minimumNumberOfUEs+1);
    time = zeros(maximumNumberOfUEs-minimumNumberOfUEs+1, 2);
    for trial = 1:1:numberOfTrials
        for numberOfUEs = minimumNumberOfUEs:1:maximumNumberOfUEs
%           [SICUEFirst, SICUELAST] = main5(numberOfUEs);
            [SICUEFirstWithInterference, SICUELASTWithInterference] = main5(numberOfUEs);
%             [SICUEFirstWithInterference, SICUELASTWithInterference, SICUEFirstWithoutInterference, SICUELastWithoutInterference] = main5(numberOfUEs);
            UEs(1, numberOfUEs-minimumNumberOfUEs+1) = numberOfUEs;
            %time(numberOfUEs-minimumNumberOfUEs+1, 1) = SICUEFirst;
            %time(numberOfUEs-minimumNumberOfUEs+1, 2) = SICUELAST;
            time(numberOfUEs-minimumNumberOfUEs+1, 1) = time(numberOfUEs-minimumNumberOfUEs+1, 1)+SICUEFirstWithInterference;
            time(numberOfUEs-minimumNumberOfUEs+1, 2) = time(numberOfUEs-minimumNumberOfUEs+1, 2)+SICUELASTWithInterference;
%             time(numberOfUEs-minimumNumberOfUEs+1, 3) = time(numberOfUEs-minimumNumberOfUEs+1, 3)+SICUEFirstWithoutInterference;
%             time(numberOfUEs-minimumNumberOfUEs+1, 4) = time(numberOfUEs-minimumNumberOfUEs+1, 4)+SICUELastWithoutInterference;
        end                            
    end
    %disp(time);
    time = time./numberOfTrials;
    %disp(time);
    %disp(size(time));
    %disp(size(UEs));
    hold on
    p = plot(UEs, time, 'LineWidth', 2, 'markers', 12 );
    xlim([minimumNumberOfUEs-1 maximumNumberOfUEs+1]);
    p(1).Marker = '+';
    p(2).Marker = 'o';
%     p(3).Marker = 'x';
%     p(4).Marker = '*';
    
    xlabel('UEs')
    ylabel('Time (seconds)')
%     legend('First UE with interference', 'Last UE with interference', 'First UE without interference', 'Last UE without interference');
    legend('First UE with interference', 'Last UE with interference');
end