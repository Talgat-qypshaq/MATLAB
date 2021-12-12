clc; clear;

UEs = [3];
%UEs = [12 11 10 9 8 7 6 5 4 3 2];
%UEs = [2 3 4 5 6 7 8 9 10 11 12];
exhaustiveSearchTime = zeros(1, length(UEs));

file_time_mean = 'Article_6_6/results/Mean_results_new/ES_time_mean.txt';

for a = 1:1:length(UEs)
    tic
        Exhaustive_Search_Mean(UEs(a));
    exhaustiveSearchTime(1, a) = toc;
    fprintf('Exhaustive search time: %.3f ms\n', exhaustiveSearchTime(1, a)*1000);
end
writematrix(round(exhaustiveSearchTime*1000, 4), file_time_mean, 'Delimiter',' ');