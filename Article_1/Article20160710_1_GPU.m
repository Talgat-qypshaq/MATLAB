
clear all;
clc;

NumberOfUsers = 5;% please enter number of users/mobile equipments

B = 50*10^6;  % Hz 

Pt = 1; %watt

N0 = 10^(-17);    %noise density watt/Hz (-210 dBm/Hz)

PowerMatrix = dlmread('data/power5_N.txt',' ');

%free space loss dB for 2 GHz
d1 = 50; %m distance for the first user
d_inc = 50; %m
f = 1*10^9; %Hz
for i = 1: 1: NumberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
end

loss = 10.^(loss./10);
snrs = 10*log10((loss.*Pt) ./ (N0*B));

%%% OMA
for i = 1:1:NumberOfUsers
    cap_oma(i) = (B/NumberOfUsers)*log2(1 + (Pt*loss(i) / (N0*B)));
end
Fairness_constraint = sum(cap_oma)^2 / (NumberOfUsers*sum(cap_oma.^2)); %%% Fairness for OFDM

Fairness_constraint = 0.9;

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
    if fairness < Fairness_constraint
        cap(i,:) = zeros(1,NumberOfUsers);
    end
    
    if fairness > maxf
        maxf = fairness;
    end
    
end

%disp(maxf);

%% finding max sum capacity
max_sum = 0;
max_sum_index = 0;
for i = 1:1:length(PowerMatrix)
    if(sum(cap(i,:)) > max_sum)
        max_sum = sum(cap(i,:));
        max_sum_index = i;
    end
end

disp(PowerMatrix(max_sum_index,:));
%disp(PowerMatrix(min_sum_index,:));

%figure
figure(1)
bar(cap(max_sum_index,:));
set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
xlabel('User equipments with optimal allocated power')
ylabel('Throughput (bps)')
sum_noma = sum(cap(max_sum_index,:));

%figure
figure(2)
bar(cap_oma);
set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
xlabel('User equipments with optimal allocated power')
ylabel('Throughput (bps)')
sum_oma = sum(cap_oma);
