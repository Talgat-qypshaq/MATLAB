clc;

UEs = [2 3 4 5 6 7 8 9 10 11 12];

DL = dlmread('DL_time.txt',' ');
Normal = dlmread('normal_time.txt',' ');

time = zeros(2, length(UEs));

for a = 1:1:length(UEs)    
    time(1, a) = DL(a);
    time(2, a) = Normal(a);
end

a = plot(UEs, time, 'LineWidth', 2 );

a(1).Marker = 'o';
a(2).Marker = 'x';

legend('DL', 'Normal');

xlabel('UEs'), ylabel('Time (ms)')