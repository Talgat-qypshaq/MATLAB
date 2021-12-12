clear;
clc;
tic;
NumberOfUsers = 5;% please enter number of user equipments
B = 50*10^6;  % Hz
Pt = 1; %watt
N0 = 10^(-17);    %noise density watt/Hz (-210 dBm/Hz)
PowerMatrixCPU = dlmread('data/power5.txt',' ');
PowerMatrix = gpuArray(PowerMatrixCPU);
%free space loss dB for 2 GHz
d1 = 50; %m distance for the first user
d_inc = 50; %m
f = 1*10^9; %Hz

loss = zeros(1, NumberOfUsers, 'gpuArray');
cap = zeros(length(PowerMatrix), NumberOfUsers, 'gpuArray');

for i = 1: 1: NumberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
end

loss = 10.^(loss./10);
snrs = 10*log10((loss.*Pt) ./ (N0*B));

%%% OMA
parfor i = 1:1:NumberOfUsers
    cap_oma(i) = (B/NumberOfUsers)*log2(1+(Pt*loss(i)/(N0*B)));
end
%fprintf('%.8f \n', cap_oma);
%%% Fairness for OFDM
CapacityOma = sum(cap_oma);
fprintf('sum capacity oma %.8f \n', CapacityOma);
Fairness_oma = CapacityOma.^2/(NumberOfUsers*sum(cap_oma.^2));
Fairness_constraint = 0.9;
fprintf('Fairness_constraint %.1f \n', Fairness_constraint);
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
%min_sum = 432344742;
%min_sum_index = 0;

%for i = 1:1:length(PowerMatrix)            
%    if(sum(cap(i,:)) < min_sum) && (sum(cap(i,:)>0))
%        min_sum = sum(cap(i,:));
%        min_sum_index = i;
%    end      
%end

%fprintf('maximum row value %.3f \n', max_sum);
%fprintf('maximum row index %d \n', max_sum_index);

%fprintf('minimum row value %.3f \n', min_sum);
%fprintf('minimum row index %d \n', min_sum_index);

%sum_noma = sum(cap(max_sum_index,:));
%sum_oma = sum(cap_oma);

%fprintf('NOMA sup capacity data throughput %.8f \n', sum(cap(max_sum_index,:)));
%fprintf('OMA data capacity throughput %.8f \n', sum_oma);

%disp(PowerMatrix(max_sum_index,:));
%disp(PowerMatrix(min_sum_index,:));

capCPU = gather(cap);
cap_omaCPU = gather(cap_oma);

tGPU = toc;
disp(['Total time on GPU:       ' num2str(tGPU)])

%figure 1
figure(1)
bar(capCPU(max_sum_index,:));
%set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
title('NOMA capacity throughput');
xlabel('User equipment')
ylabel('Throughput (bps)')
set(gca,'FontSize', 16)

%figure 2
figure(2)
bar(cap_omaCPU, 'y');
%set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
title('OMA capacity throughput');
xlabel('User equipment')
ylabel('Throughput (bps)')
set(gca,'FontSize', 16)

%figure 3
%figure(3)
%bar(cap(min_sum_index,:));
%set(gca,'xticklabel', PowerMatrix(min_sum_index,:));
%title('NOMA capacity throughput');
%xlabel('User equipments with non-optimally allocated power')
%ylabel('Throughput (bps)')