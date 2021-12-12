clc; clear;

UEs = [2 3 4 5 6 7 8 9 10 11 12];
%UEs = 3;
exhaustiveSearchTime = zeros(1, length(UEs));

file_time = 'Article_6_6/results/ES_results_new/ES_time.txt';

for a = 1:1:length(UEs)
    tic
        Exhaustive_Search(UEs(a));
    exhaustiveSearchTime(1, a) = toc;
    fprintf('Exhaustive search time: %.3f ms\n', exhaustiveSearchTime(1, a)*1000);
end

writematrix(round(exhaustiveSearchTime*1000, 4), file_time, 'Delimiter',' ');