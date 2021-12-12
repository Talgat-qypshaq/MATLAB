%% initiate parameters
clc; clear;
number_of_users = 3;
B = 20*10^6;  % Hz 
P_T = 0.1; % Watt
G_T = 1; % Transmitter channel gain
G_R = 1; % Teceiver channel gain
lambda = 30;
N0 = 10^(-17); %Noise density watt/Hz (-210 dBm/Hz)
PowerMatrix = dlmread(strcat('data/PowerAllocation', strcat(num2str(number_of_users),'.txt')),' ');
fairness_constraint = 0.9;
%for z = 1:1:length(PowerMatrix)
%    fprintf('z = %d; P1 = %.3f; P2 = %.3f; \n', z, PowerMatrix(z, 1), PowerMatrix(z,2));
%end
%% free space path loss 2
%free space loss dB for 2 GHz
d1 = 50; %m distance for the first user
d_inc = 50; %m
f = 6*10^9; %Hz
loss = zeros(1, number_of_users);
%free space path loss
for i = 1: 1: number_of_users
    loss(i) = P_T*G_T*G_R*power((lambda/(4*pi*(d1 + d_inc*(i - 1)))),2);    
    %fprintf('a1 = %.5f;a2 = %.5f;\n',-20*log10(d1 + d_inc*(i - 1)),- 20*log10(f));
    %loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55;
    %loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 197.55;
end
%fprintf('loss a = %.12f;\n', loss);
%loss = 10.^(loss./10);
fprintf('loss b = %.12f;\n', loss);
% for i = 1: 1: number_of_users
%     loss(i) = 1;
% end
%snrs = 10*log10((loss.*Pt) ./ (N0*B));
%fprintf('snrs = %.3f;\n', snrs);
%% capacity NOMA
capacity = zeros(length(PowerMatrix), number_of_users); maxf = 0; maxi = 0;fairness_array = zeros(length(PowerMatrix));
for i = 1:1:length(PowerMatrix)
    powers = PowerMatrix(i,:);
    for  u = 1:1:number_of_users
        interf_power = 0;
        for u_interf = (u-1):-1:1
            interf_power = interf_power + powers(u_interf)*P_T*loss(u);
        end
        if (i==1)
            fprintf('UE %d interference = %.12f;\n',u,interf_power);
        end
        capacity(i,u) = B*log2( 1 + powers(u)*P_T*loss(u) / (N0*B + interf_power) );
    end
    fairness_array(i) = (capacity(i,1)+capacity(i,2))^2 / (2*(capacity(i,1)^2+capacity(i,2)^2));
    if fairness_array(i) < fairness_constraint
        capacity(i,:) = zeros(1, number_of_users);
    end
    if ( (fairness_array(i) > maxf) && (fairness_array(i) < 0.99) )
        maxf = fairness_array(i);
        maxi = i;
    end
end
for a = 1:1:length(PowerMatrix)
   if(capacity(a,1)>0 && capacity(a,2)>0)
       fprintf('i = %d; fc = %.3f; UE1 = %.3f; UE2 = %.3f; P1 = %.3f; P2 = %.3f;\n', a, fairness_array(a), capacity(a,1)/1000000, capacity(a,2)/1000000, PowerMatrix(a,1), PowerMatrix(a,2));
   end
end
%disp('finished');
%% finding max sum capacity
max_sum = 0;
max_sum_index = 0;
for i = 1:1:length(PowerMatrix)            
    if(sum(capacity(i,:)) > max_sum)
        max_sum = sum(capacity(i,:));
        max_sum_index = i;
    end      
end
sc = capacity(maxi,1)/1000000 + capacity(maxi,2)/1000000;
fprintf('msc = %.3f; fc = %.3f;  i = %d; UE1 = %.1f Mbps; UE2 = %.1f Mbps; P1 = %.3f; P2 = %.3f;\n',max_sum/1000000,fairness_array(max_sum_index),max_sum_index,capacity(max_sum_index,1)/1000000, capacity(max_sum_index,2)/1000000, PowerMatrix(max_sum_index,1), PowerMatrix(max_sum_index,2));
fprintf('sc = %.3f; mfc = %.3f; mi = %d; UE1 = %.1f Mbps; UE2 = %.1f Mbs; P1 = %.3f; P2 = %.3f;\n',sc,maxf,maxi,capacity(maxi,1)/1000000, capacity(maxi,2)/1000000, PowerMatrix(maxi,1), PowerMatrix(maxi,2));