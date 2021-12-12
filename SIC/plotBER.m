function [ ] = plotBER()
    clc;
    numberOfSimulations = 1000;
    BER = zeros(5);
    ErrorsPerRatio = zeros(1, numberOfSimulations);
    summOfErrorsPerRatio = zeros(1, 5);
    for ratio = 1:1:5
        for EbNo = 1:1:numberOfSimulations
            errors = main4(ratio);
            ErrorsPerRatio(1, EbNo) = errors;
        end        
        summOfErrorsPerRatio(1, ratio) = sum(ErrorsPerRatio, 2);        
        BER (ratio) = summOfErrorsPerRatio(1, ratio)/(numberOfSimulations*6);
        disp(BER (ratio));
    end
    
    Ratio = 1:1:5;
    plot(Ratio, BER);   
    xlabel('Ratios');
    ylabel('Bit Error Rate');
    StrNumberOfSimulations = num2str(numberOfSimulations);
    StrLegend = strcat('BER in particular ratio within ', StrNumberOfSimulations);
    StrLegend = strcat(StrLegend, ' simulations');
    legend(StrLegend);
    %set(gca,'XTickLabel', {'31-34-35', '1-45-54', '10-40-50', '1-9-90', '10-20-70'});
    set(gca,'XTick',[1 2 3 4 5],'XTickLabel',{'31-34-35','1-45-54','10-40-50','10-20-70','1-9-90'});
end