function [ ] = plotElapsedTime3()
    clc;
    numberOfSimulations = 10;
    errorsArray = zeros(3, 10);
    ratio = 13;
    %for ratio = 1:1:3
        for EbNo = 1:1:numberOfSimulations
            errorsArray (ratio, EbNo) = main3(ratio);                                    
        end
    %end
    EbN0 = 1:1:100;
    %fprintf([repmat('%.10f\t', 1, size(plotArray, 2)) '\n'], plotArray')
    p = plot(EbN0, errorsArray, 'LineWidth', 2 );
    xlim([1 100]);
    p(1).Marker = 'o';
    %p(2).Marker = 'x';
    %p(3).Marker = '*';
    
    xlabel('EbNo');
    ylabel('bit error rate');
    %legend('0.01/0.09/0.9', '0.3/0.31/0/39', '0.1/0,3/0.6');
        
end