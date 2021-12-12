function [optimumPower] = OptimumPowerAllocation(numberOfUsers, fairness_constraint)
B = 50*10^6;  % Hz
Pt = 1; %watt
N0 = 10^(-17); %noise density watt/Hz (-210 dBm/Hz)
PowerMatrix = dlmread('data/PowerAllocation.txt', ' ');
%free space loss dB for 2 GHz
d1 = 50; %m distance for the first user
d_inc = 50; %m
f = 1*10^9; %Hz
loss = zeros(1, numberOfUsers);
cap = zeros(length(PowerMatrix), numberOfUsers);
for i = 1:1:numberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
end
loss = 10.^(loss./10);
maxf = 0;   % keep max. fairness
minf = 0.5; % the minimum fairness constraint we can trust
maxfairness_rounded = 0;  % the maximum fairness constraint rounded
fairness_rounded = 0; % rounded calculated fairness constraint
if fairness_constraint < minf
    fprintf('Fairness constraint should be equal to or higher than 0.5 and it was set to 0.5 \n');
    fairness_constraint = minf;
end

for i = 1:1:size(PowerMatrix, 1)
    powers = PowerMatrix(i,:);       
    for  u = 1:1:numberOfUsers
        interf_Power = 0;
        for u_interf = (u-1):-1:1
            interf_Power = interf_Power + powers(u_interf)*Pt*loss(u);
        end
        cap(i,u) = B*log2(1 + powers(u)*Pt*loss(u)/(N0*B + interf_Power));                       
    end
    
    fairness = sum(cap(i,:))^2/(numberOfUsers*sum(cap(i,:).^2));
    fairness_rounded = floor(fairness*10)/10;
    
    if fairness > maxf
        maxf = fairness;
        if fairness_rounded > maxfairness_rounded
            maxfairness_rounded = fairness_rounded;
        end        
    end
    
    %if calculated fairness constraint is less than 0,5 we can't trust
    if fairness < minf
        cap(i,:) = zeros(1, numberOfUsers);
    else
        if fairness > minf && fairness < maxfairness_rounded && fairness < fairness_constraint
            cap(i,:) = zeros(1,numberOfUsers);
        end
    end            
    %if fairness < fairness_constraint
    %    cap(i,:) = zeros(1,numberOfUsers);
    %end    
    
end
    fprintf('calculated maximum fairness constraint is %s \n', num2str(maxf));
if(maxf < minf)
    fprintf('the calculated maximum fairness constraint is less than 0.5, we cannot trust this simulations \n');
    optimumPower = zeros(1, numberOfUsers);
    return;
end
%% finding max sum capacity
max_sum = 0;
max_sum_index = 0;
for i = 1:1:length(PowerMatrix)            
    if(sum(cap(i,:)) > max_sum)
        max_sum = sum(cap(i,:));
        max_sum_index = i;
    end      
end
optimumPower = PowerMatrix(max_sum_index, :);
end