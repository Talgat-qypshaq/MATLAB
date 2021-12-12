%cluster based loop call
clc;
clear;
FFT = [512 1024 2048 4096];
numberOfClusters = [32 96 160 192];
NumberOfUEs = 10;
whichUE = 10;
ic = ['S' 'P'];
arraySize = size(numberOfClusters, 2);

for a = 1:1:size(ic, 2)
    for b = 1:1:size(FFT, 2)
        for c = 1:1:size(numberOfClusters, 2)    
            timeResult = 0;
            for d = 1:1:numberOfClusters(c)
                timeResult = timeResult + OFDM_CALL(FFT(b), ic(a));            
            end
            fprintf('FFT = %d; number of clusters = %d; %sIC; time = %.5f; \n', FFT(b), numberOfClusters(c), ic(a), timeResult);        
        end
    end
end

% timeResult = 0;
% for j = 1:1:96
%     timeResult = OFDM_CALL(1024, ic(2));
% end
% 
% fprintf('FFT = %d; number of clusters = %d; time = %.5f; \n', 1024, 96, timeResult);