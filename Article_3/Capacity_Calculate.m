clc;
B = 50*10^6;  % Hz 
Pt = 1; %watt
N0 = 10^(-17);    %noise density watt/Hz (-210 dBm/Hz)
NumberOfUsers = 13;% please enter number of user equipments
PowerMatrix = dlmread('data/PowerAllocation13.txt',' ');
Fairness_constraint = 0.4;
%free space loss dB for 2 GHz
d1 = 50; %m distance for the first user
d_inc = 50; %m
f = 1*10^9; %Hz
loss = zeros(1, NumberOfUsers);
cap = zeros(length(PowerMatrix), NumberOfUsers);
for i = 1: 1: NumberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
end

loss = 10.^(loss./10);
snrs = 10*log10((loss.*Pt) ./ (N0*B));

tic
%fprintf('Fairness_constraint %.1f \n', Fairness_constraint);
%%%% NOMA
maxf = 0; %just to keep max. fairness
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
    if fairness < Fairness_constraint        
        cap(i,:) = zeros(1,NumberOfUsers);
    end
    if fairness > maxf
        maxf = fairness;
    end
end

%fprintf('maximum fairness constraint %.3f \n', fairness2);

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
sum_noma = sum(cap(max_sum_index,:));

toc

fprintf('maximum row value %.3f \n', max_sum);
fprintf('maximum row index %d \n', max_sum_index);

fprintf('minimum row value %.3f \n', min_sum);
fprintf('minimum row index %d \n', min_sum_index);

fprintf('capacity NOMA %.8f \n', sum_noma);

%disp(cap(max_sum_index,:));
%disp(PowerMatrix(max_sum_index,:));
%disp(PowerMatrix(min_sum_index,:));