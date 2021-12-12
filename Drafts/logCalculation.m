function [i, logarithm] = logCalculation(startLog, endLog)
    persistent storeValue;
    logarithm = zeros(1, endLog);
    if isempty(storeValue), storeValue = 1; end
    clc;
    for i=startLog:0.1:1
        %fprintf('%.5f\n',i);
        logarithm(storeValue) = log2(i);
        fprintf('%.5f, %.5f \n', i, logarithm);
        %if(logarithm(i)>=1 && logarithm(i)<=3)
            storeValue = storeValue+1;
        %end
    end
%     plot (logarithm, 'R');
%     hold on
%     grid on; box on;
%     xlabel('i') %Label for x-axis
%     ylabel('logarithm') %Label for y-axis
%     %legend('logarithm');
%     hold on
    %fprintf('%d \n', storeValue);
end