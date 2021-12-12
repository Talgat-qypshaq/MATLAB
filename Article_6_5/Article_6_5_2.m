%only for two distances 318 and 125 meters
clc;
NumberOfUsers = 2;% please enter number of user equipments
d1 = 235;
d_inc = 25;
%d1 = 125;
%d_inc = 318;

fairnessConstraint = 0.7;

B = 50*10^6;% Hz
Pt = 1; %watt
N0 = 10^(-17);    %noise density watt/Hz (-210 dBm/Hz)
PowerMatrix = dlmread('data/power2.txt',' ');
powerArray = zeros(length(PowerMatrix), NumberOfUsers);
%free space loss dB for 2 GHz        

f = 1*10^9; %Hz
loss = zeros(1, NumberOfUsers);
cap_oma = zeros(1, NumberOfUsers);
cap = zeros(length(PowerMatrix), NumberOfUsers);
tic
for i = 1: 1: NumberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
end
loss = 10.^(loss./10);
snrs = 10*log10((loss.*Pt) ./ (N0*B));
    
%%% OMA
for i = 1:1:NumberOfUsers
    cap_oma(i) = (B/NumberOfUsers)*log2(1+(Pt*loss(i)/(N0*B)));
end
%%% Fairness for OMA
CapacityOma = sum(cap_oma);
Fairness_oma = CapacityOma.^2/(NumberOfUsers*sum(cap_oma.^2));
%%%% NOMA
maxf = 0; %just to keep max. fairness

capacityNOMA = zeros(4, NumberOfUsers+1);

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
    if fairness < fairnessConstraint
        cap(i,:) = zeros(1,NumberOfUsers);
    else
        powerArray(i,:) = powers;
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
elapsed_time = toc;
%% finding min sum capacity
%min_sum = 432344742;
%min_sum_index = 0;
%for i = 1:1:length(PowerMatrix)            
%    if(sum(cap(i,:)) < min_sum) && (sum(cap(i,:)>0))
%        min_sum = sum(cap(i,:));
%        min_sum_index = i;
%    end      
%end        
%for a=1:1:NumberOfUsers
%    fprintf(a+" "+distance(a)+" "+cap(max_sum_index,a)+" "+powerArray(max_sum_index,a)+'\n');
%    fprintf('user %d distance: %d; data rate: %.3f; power coefficient: %.2f\n',a, distance(a), cap(max_sum_index,a),powerArray(max_sum_index,a)); 
%end
sum_noma = sum(cap(max_sum_index,:));
sum_oma = sum(cap_oma);

fprintf('exhaustive search time: %.2f ms\n',elapsed_time*1000);

fprintf('capacity NOMA %.2f Mbps;\n', sum_noma/1000000);
fprintf('capacity OMA %.2f Mbps; \n', sum_oma/1000000);

%disp(cap(max_sum_index,:));
disp(PowerMatrix(max_sum_index,:));
%disp(PowerMatrix(min_sum_index,:));