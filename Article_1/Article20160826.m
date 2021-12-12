clc;
NumberOfUsers = 13;% please enter number of user equipments
Fairness_constraint = 0.4;
NumberOfUsersArray = zeros(1, NumberOfUsers);
B = 50*10^6;  % Hz 
Pt = 1; %watt
N0 = 10^(-17);    %noise density watt/Hz (-210 dBm/Hz)
%PowerMatrix = dlmread('data/power13.txt',' ');
fileName = strcat('data/PowerAllocation', num2str(NumberOfUsers));
fileName = strcat(fileName,'.txt');
PowerMatrix = dlmread(fileName, ' ');
%free space loss dB for 2 GHz
d1 = 50; %m distance for the first user
d_inc = 50; %m
f = 1*10^9; %Hz
loss = zeros(1, NumberOfUsers);
cap_oma = zeros(1, NumberOfUsers);
cap = zeros(length(PowerMatrix), NumberOfUsers);
for i = 1: 1: NumberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
end
loss = 10.^(loss./10);
snrs = 10*log10((loss.*Pt) ./ (N0*B));
%%% OMA
for i = 1:1:NumberOfUsers
    cap_oma(i) = (B/NumberOfUsers)*log2(1+(Pt*loss(i)/(N0*B)));
end
%fprintf('%.8f \n', cap_oma);
%%% Fairness for OFDM
CapacityOma = sum(cap_oma);
fprintf('sum capacity oma %.8f \n', CapacityOma);
Fairness_oma = CapacityOma.^2/(NumberOfUsers*sum(cap_oma.^2));
fprintf('Fairness index oma %.8f \n', Fairness_oma);
%fprintf('Fairness_constraint %.1f \n', Fairness_constraint);
%%%% NOMA
maxf = 0; %just to keep max. fairness
%fairnessConstraintArray = [0.3, 0.5, 0.7, 0.9];
fairnessConstraintArray = 0.444;
capacityNOMA = zeros(4, NumberOfUsers+1);
capacityComparison1 = zeros(1, NumberOfUsers);
capacityComparison2 = zeros(1, NumberOfUsers);
capacityComparison = zeros(2, NumberOfUsers);
%for fc = 1:numel(fairnessConstraintArray)
    for i = 1:1:length(PowerMatrix)
        powers = PowerMatrix(i,:);
        for  u = 1:1:NumberOfUsers
            interf_Power = 0;
            for u_interf = (u-1):-1:1
                interf_Power = interf_Power + powers(u_interf)*Pt*loss(u);
            end
            cap(i,u) = B*log2(1 + powers(u)*Pt*loss(u) / (N0*B + interf_Power));
        end
        
        fairness = sum(cap(i,:))^2 / (NumberOfUsers*sum(cap(i,:).^2));
        if(i == 1)
            fairness2 = fairness;
        end
        %if fairness < Fairness_constraint
        %if fairness < fairnessConstraintArray(fc)
        if fairness < fairnessConstraintArray
            cap(i,:) = zeros(1,NumberOfUsers);
        end
        if fairness > maxf
            maxf = fairness;
        end
    end
fprintf('maximum fairness constraint %.3f \n', fairness2);
%% finding max sum capacity
max_sum = 0;
max_sum_index = 0;

for i = 1:1:length(PowerMatrix)            
    if(sum(cap(i,:)) > max_sum)
        max_sum = sum(cap(i,:));
        max_sum_index = i;
    end      
end

%% finding min sum capacity
min_sum = 432344742;
min_sum_index = 0;

for i = 1:1:length(PowerMatrix)            
    if(sum(cap(i,:)) < min_sum) && (sum(cap(i,:)>0))
        min_sum = sum(cap(i,:));
        min_sum_index = i;
    end      
end

fprintf('maximum row value %.3f \n', max_sum);
fprintf('maximum row index %d \n', max_sum_index);

fprintf('minimum row value %.3f \n', min_sum);
fprintf('minimum row index %d \n', min_sum_index);

sum_noma = sum(cap(max_sum_index,:));
sum_oma = sum(cap_oma);

fprintf('capacity NOMA %.8f \n', sum_noma);
fprintf('capacity OMA %.8f \n', sum_oma);

%disp(cap(max_sum_index,:));
%disp(PowerMatrix(max_sum_index,:));
%disp(PowerMatrix(min_sum_index,:));
    %for figure 4    
%     for u=1:NumberOfUsers+1
%         if(u==1)
%             capacityNOMA(fc, u) = sum_noma;
%         end
%         if(u>1)
%             capacityNOMA(fc, u) = cap(max_sum_index, u-1);
%         end;
%     end    
    %for figure 5
    for u=1:NumberOfUsers
        NumberOfUsersArray(1, u) = u;
        for v=1:1:2
            if(v==1)
                capacityComparison(v, u) = cap(max_sum_index,u);
            end
            if(v==2)
                capacityComparison(v, u) = cap_oma(1, u);
            end
            %capacityComparison1(1, u) = cap(max_sum_index,u);
            %capacityComparison2(1, u) = cap_oma(1, u);
        end
    end
    disp(capacityComparison);
%end
%disp(capacityComparison);
%figure 5
%figure(1)
%p = plot(NumberOfUsersArray, capacityComparison, 'LineWidth', 2 );
%p(1).Marker = 'o';
%p(2).Marker = '*';

%title('NOMA and OMA capacity throughput');
%xlabel('Number of User Equipments');
%ylabel('Throughput (bps)');
%legend('NOMA Capacity', 'OMA');

%figure 1
% figure(1)
% bar(cap(max_sum_index,:)); 
% set(gca,'xticklabel', PowerMatrix(max_sum_index,:)); 
% title('NOMA capacity throughput');
% xlabel('User equipments with optimally allocated power')
% ylabel('Throughput (bps)')

%figure 2
% figure(2)
% bar(cap_oma);
% set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
% title('OMA capacity throughput');
% xlabel('User equipments with optimally allocated power')
% ylabel('Throughput (bps)')

%figure 3
%figure(3)
%bar(cap(min_sum_index,:));
%set(gca,'xticklabel', PowerMatrix(min_sum_index,:));
%title('NOMA capacity throughput');
%xlabel('User equipments with non-optimally allocated power')
%ylabel('Throughput (bps)')

%figure 4
% figure(4)
% p = plot(fairnessConstraintArray, capacityNOMA, 'LineWidth', 2 );
% p(1).LineWidth = 3;
% p(2).Marker = 'x';
% p(3).Marker = 'o';
% p(4).Marker = '*';
% p(5).Marker = '.';
% p(6).Marker = '+';

%title('Capacity obtained with five UEs for different fairness indexes');
%xlabel('Fairness Index')
%ylabel('Throughput (bps)')
%legend('SUM CAPACITY','UE1','UE2','UE3','UE4','UE5');