clc;

UEs = [2 3 4 5 6 7 8 9 10 11 12];

ES = dlmread('ES_time_mean.txt',' ');
Gradient = dlmread('gradient_time.txt',' ');
Normal = dlmread('normal_time.txt',' ');
DL = dlmread('DL_time.txt',' ');

time = zeros(4, length(UEs));

for a = 1:1:length(UEs)
    time(1, a) = ES(a);
    time(2, a) = Gradient(a);
    time(3, a) = Normal(a);
    time(4, a) = DL(a);
end

a = plot(UEs, time, 'LineWidth', 2 );

a(1).Marker = 'o';
a(2).Marker = 'x';
a(3).Marker = '+';
a(4).Marker = '*';

legend('ES', 'Gradient', 'Normal', 'DL')

xlabel('UEs'), ylabel('Time (ms)')