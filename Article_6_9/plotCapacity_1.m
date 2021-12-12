clc;

UEs = [2 3 4 5 6 7 8 9 10 11 12];

Normal = dlmread('capacity_normal.txt',' ');
ES = dlmread('capacity_ES.txt',' ');
DL = dlmread('capacity_dl.txt',' ');

sum_capacity = zeros(3, length(UEs));

for a = 1:1:length(UEs)    
    sum_capacity(1, a) = ES(a);
    sum_capacity(2, a) = Normal(a);
    sum_capacity(3, a) = DL(a);
end

a = plot(UEs, sum_capacity, 'LineWidth', 2 );
set(gca,'Ylim',[230 265])

%a(1).Marker = 'o';
%a(2).Marker = '+';
%a(3).Marker = '*';

legend('Exhaustive search', 'Normal equation', 'Deep learning')

xlabel('Number of users (K)'), ylabel('Sum capacity (Mbits/sec)')