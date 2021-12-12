%% This function writes optimum power allocation coefficients 
%% for preset number of UEs in a file.
function [] = Exhaustive_Search(NumberOfUsers)
    %original parameters
    B = 50*10^6;% Hz 
    Pt = 1; %watt
    N0 = 10^(-17); %noise density watt/Hz (-210 dBm/Hz)        
    f = 1*10^9; %Hz
    
    fileName = strcat('Article_6_6/data/coefficients_', num2str(NumberOfUsers));
    fileName = strcat(fileName,'.txt');
    PowerMatrix = dlmread(fileName,' ');
    
    %fileName = strcat('Article_6_6/data/ES_fairness_', num2str(NumberOfUsers));
    %fileName = strcat(fileName,'.txt');
    %FairnessVector = dlmread(fileName,' ');
    
    allDistances = dlmread('Article_6_6/data/all_distances.txt','\t');
    
    % arrays that will be writted to a file start    
    powerArray = zeros(length(allDistances), NumberOfUsers);
    maximumSumCapacityArray = zeros(length(allDistances), 1);
    % arrays that will be writted to a file end
    for d = 1:1:length(allDistances)
        %fairnessConstraint = FairnessVector(d) - 0.1;
        loss = zeros(1, NumberOfUsers);
        cap = zeros(length(PowerMatrix), NumberOfUsers);
        for i = 1: 1: NumberOfUsers
            distance = allDistances(d,i);
            loss(i) = -20*log10(distance) - 20*log10(f) + 147.55; %free space path loss
        end
        loss = 10.^(loss./10);
        %snrs = 10*log10((loss.*Pt) ./ (N0*B));        
        %NOMA
        maxf = 0; %just to keep max. fairness
        for i = 1:1:length(PowerMatrix)
            powers = PowerMatrix(i,:);
        for u = 1:1:NumberOfUsers 
            interf_Power = 0; 
            for u_interf = (u-1):-1:1
                h = (randn(1,1000) + 1i*randn(1,1000) )/sqrt(2); %Rayleigh flat channel 
                interf_Power = interf_Power + mean(powers(u_interf)*((abs(h).^2).')*Pt*loss(u)); 
            end 
            h = (randn(1,1000) + 1i*randn(1,1000) )/sqrt(2); %Rayleigh flat channel 
            cap(i,u) = mean(B*log2(1 + powers(u)*((abs(h).^2).')*Pt*loss(u) / (N0*B + interf_Power))); 
        end
            %fairness = sum(cap(i,:))^2 / (NumberOfUsers*sum(cap(i,:).^2));
            %if fairness < fairnessConstraint
            %    cap(i,:) = zeros(1,NumberOfUsers);
            %end
            %if fairness > maxf
            %    maxf = fairness;
            %end
        end
        %fprintf('Maximum fairness constraint %.3f \n', maxf);
        %% finding max sum capacity
        max_sum = 0;
        max_sum_index = 0;
        for i = 1:1:length(PowerMatrix)            
            if(sum(cap(i,:)) > max_sum)
                max_sum = sum(cap(i,:));
                max_sum_index = i;
            end      
        end
        maximumSumCapacityArray(d) = round(sum(cap(max_sum_index,:))/1000000,0);
        %sum_noma = sum(cap(max_sum_index,:));
        %fprintf('sum capacity NOMA: %d Mbits;\n', round(sum_noma/1000000,0));
        %disp(PowerMatrix(max_sum_index,:));      
        powerArray(d, :) = PowerMatrix(max_sum_index,:);
    end
        
        file_power = strcat('Article_6_6/results/ES_results_new/ES_coefficients_', num2str(NumberOfUsers));
        file_power = strcat(file_power,'.txt');
        
        file_capacity = strcat('Article_6_6/results/ES_results_new/ES_capacity_', num2str(NumberOfUsers));
        file_capacity = strcat(file_capacity,'.txt');
        
        writematrix(powerArray, file_power, 'Delimiter',' ');
        writematrix(maximumSumCapacityArray, file_capacity, 'Delimiter',' ');
end