function [optimumPower] = OptimumPowerAllocation(numberOfUsers, fairness_constraint)
B = 50*10^6;  % Hz
Pt = 1; %watt
N0 = 10^(-17); %noise density watt/Hz (-210 dBm/Hz)
PowerMatrix = dlmread('data/PowerAllocation10.txt', ' ');
loss = channelGain(numberOfUsers);
cap = zeros(length(PowerMatrix), numberOfUsers);
maxf = 0;   % keep max. fairness
minf = 0.4; % the minimum fairness constraint we can trust
maxfairness_rounded = 0;  % the maximum fairness constraint rounded
fairness_rounded = 0; % rounded calculated fairness constraint
if fairness_constraint < minf
    fprintf('Fairness constraint should be equal to or higher than %s and your set fairness constraint is %s \n', num2str(minf), num2str(fairness_constraint));
    fairness_constraint = minf;
end
tic
disp(size(PowerMatrix, 1));
for i = 1:1:size(PowerMatrix, 1)
    powers = PowerMatrix(i,:);
    for  u = 1:1:numberOfUsers
        interf_Power = 0;
        powerSU = 0;
        for u_interf = (u-1):-1:1
            %fprintf('u=%d u_interf=%d loss=%d \n',u, u_interf, loss(u));
            interf_Power = interf_Power + powers(u_interf)*Pt*loss(u);
            powerSU = powerSU + powers(u_interf);
        end
        %fprintf('u=%d; PSU = %.3f \n', u, powerSU);
        %fprintf('u=%d; interf_Power=%s \n', u, num2str(interf_Power, '%.27f'));
        %fprintf('u=%d; loss=%s \n', u, num2str(loss(u), '%.27f'));
        %fprintf('u=%d; power=%s \n', u, num2str(powers(u), '%.27f'));
        cap(i,u) = B*log2(1+powers(u)*Pt*loss(u)/(N0*B + interf_Power));        
        %fprintf('u=%d; part1=%s \n', u, num2str((N0*B + interf_Power), '%.27f'));
        %G =        B*log2(1+powers(u)*Pt*loss(u)/(N0*B + interf_Power));
        %fprintf('u=%d; i=%d; powers=%s \n', u, i, num2str(G, '%.4f'));
        %thread = i*u;
        %fprintf('u=%d; i=%d; thread=%d; capacity=%s \n', u, i, thread, num2str(cap(i,u), '%.4f'));
    end
    %fprintf('i=%d; sum capacity=%s \n', (13*i)-1, num2str(sum(cap(i,:)), '%.4f'));
    fairness = sum(cap(i,:))^2/(numberOfUsers*sum(cap(i,:).^2));        
    fairness_rounded = floor(fairness*10)/10;
    %fprintf('i=%d; fairness_rounded=%s \n', (13*i)-1, num2str(fairness_rounded, '%.1f'));
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
end
%fprintf('calculated maximum fairness constraint is %s \n', num2str(maxf));
if(maxf < minf)
    fprintf('the calculated maximum fairness constraint is less than %s, we cannot trust this simulations \n', num2str(minf));
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
toc;
fprintf('max sum = %.3f; max sum index = %d\n', max_sum, max_sum_index);
optimumPower = PowerMatrix(max_sum_index, :);
%disp(optimumPower);
end