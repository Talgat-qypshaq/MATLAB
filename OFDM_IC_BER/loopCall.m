clc;
clear;

OFDM_CALL(5, 4096);

% FFT = [512 1024 2048 4096];
% UE = [50 100 150 200 250 300 350];
% NumberOfUEs = size(UE, 2);

% for b = 1:1:size(FFT, 2)
%     for c = 1:1:size(UE, 2)
%         fprintf('FFT = %d; UE = %d; %sIC; \n', FFT(b), UE(c));
%         OFDM_CALL(UE(c), FFT(b));
%         fprintf('FFT = %d; UE = %d; %sIC; time = %.5f ms; \n', FFT(b), UE(c), timeResult*1000);
%     end
% end

%timeResult = OFDM_CALL(10, 4096);
%fprintf('FFT = %d; UE = %d; Which UE = %d; time = %.5f ms; \n', 4096, 10, 9, timeResult);

% timeResult = OFDM_CALL(UE(2), FFT(2), ic(1));
% fprintf('FFT = %d; UE = %d; %sIC time = %.5f ms; \n', 1024, 960, 'S', timeResult);
% timeResult = OFDM_CALL(UE(2), FFT(2), ic(2));
% fprintf('FFT = %d; UE = %d; %sIC time = %.5f ms; \n', 1024, 960, 'P', timeResult);