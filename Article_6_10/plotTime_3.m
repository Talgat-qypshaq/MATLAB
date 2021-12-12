clc;

UEs = [2 3 4 5 6 7 8 9 10 11 12];

ES = dlmread('ES_time_mean.txt',' ');
Normal = dlmread('normal_time.txt',' ');
DL = dlmread('DL_time.txt',' ');

time = zeros(3, length(UEs));

for a = 1:1:length(UEs)
    time(1, a) = ES(a);
    time(2, a) = Normal(a);
    time(3, a) = DL(a);
end

a = plot(UEs, time, 'LineWidth', 2 );

a(1).Marker = 'o';
a(2).Marker = 'x';
a(3).Marker = '+';

legend('ES', 'Normal', 'DL')

xlabel('UEs'), ylabel('Time (ms)')