clc;

UEs = [2 3 4 5 6 7 8 9 10 11 12];

model = ["ES", "GRADIENT", "Normal", "DL"];
fairness = zeros(length(model), length(UEs));

for m = 1:1:length(model)
    for a = 1:1:length(UEs)
        capacities = zeros(1, UEs(a));
        for b = 1:1:UEs(a)
            file_to_read = strcat('Article_6_12/data/', model(m));
            file_to_read = strcat(file_to_read, '_capacity_');
            file_to_read = strcat(file_to_read, num2str(UEs(a)));
            file_to_read = strcat(file_to_read, '_');
            file_to_read = strcat(file_to_read, num2str(b));
            file_to_read = strcat(file_to_read, '.txt');
            capacity = dlmread(file_to_read,' ');
            capacities(1, b) = capacity;
        end
        %sum(capacities(1,:))^2 / (UEs(a)*sum(capacities(1,:).^2))
        fairness(m, a) = sum(capacities(1,:))^2 / (UEs(a)*sum(capacities(1,:).^2));

        %% write capacity into files    
        file_fairness = strcat(model(m), '_fairness_');
        file_fairness = strcat(file_fairness, num2str(UEs(a)));    
        file_fairness = strcat(file_fairness,'.txt');
        file_fairness = strcat('Article_6_12/results/', file_fairness);
        writematrix(fairness, file_fairness, 'Delimiter',' ');
    end        
end

a = plot(UEs, fairness, 'LineWidth', 2 );
a(1).Marker = 'o';
a(2).Marker = 'x';
a(3).Marker = '+';
a(4).Marker = '*';

legend("ES", "GRADIENT", "Normal", "DL")
xlabel('UEs'), ylabel('Fairness index')

% DL = dlmread('data/capacity_dl.txt',' ');
% Normal = dlmread('data/capacity_normal.txt',' ');
% Gradient = dlmread('data/capacity_gradient.txt',' ');
% ES = dlmread('data/capacity_ES.txt',' ');
% 
% sum_capacity = zeros(4, length(UEs));
% 
% for a = 1:1:length(UEs)
%     sum_capacity(1, a) = DL(a);
%     sum_capacity(2, a) = Normal(a);
%     sum_capacity(3, a) = Gradient(a);
%     sum_capacity(4, a) = ES(a);
% end
% 
% a = plot(UEs, sum_capacity, 'LineWidth', 2 );
% a(1).Marker = 'o';
% a(2).Marker = 'x';
% a(3).Marker = '+';
% a(4).Marker = '*';
% 
% legend('DL', 'Normal', 'Gradient', 'ES')
% xlabel('UEs'), ylabel('Sum capacity (Mbits/sec)')