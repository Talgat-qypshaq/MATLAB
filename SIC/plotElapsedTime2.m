function [ ] = plotElapsedTime2()
    clc;
    minUEs = 5;
    maxUEs = 13;
    numberOfSimulations = maxUEs-minUEs+1;
    plotArray = zeros(numberOfSimulations, 2);
    time = zeros(numberOfSimulations, 2);
    Ratio = zeros(1, numberOfSimulations);
        for ratio = minUEs:1:maxUEs            
            [SICUEFirst, SICUELAST] = main2(ratio);   
            plotArray (ratio-minUEs+1, 1) = SICUEFirst;
            plotArray (ratio-minUEs+1, 2) = SICUELAST;            
            Ratio(1, ratio) = ratio;           
            time(ratio, 1) = SICUEFirst;
            time(ratio, 2) = SICUELAST;
            %fprintf('first UE ratio %.9f \n', SICUEFirst); 
            %fprintf('second UE ratio %.9f \n', SICUELAST);
        end    
    fprintf([repmat('%.10f\t', 1, size(plotArray, 2)) '\n'], plotArray')
    p = plot(Ratio, time, 'LineWidth', 2 );
    xlim([1 5]);
    p(1).Marker = 'o';
    p(2).Marker = 'x';
    
    xlabel('Ratios');
    ylabel('Time (seconds)');
    legend('First UE', 'Last UE');
    
    set(gca,'XTickLabel', {'0.1/0.9', ' ' , '0.2/0.8', ' ' , '0.3/0.7', ' ' , '0.4/0.6', ' ' , '0.45/0.55'});
end