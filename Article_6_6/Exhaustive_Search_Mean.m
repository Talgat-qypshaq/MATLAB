%% This function calculates optimum power allocation coefficients 
%% for mean distances and writes them in files
function [] = Exhaustive_Search_Mean(NumberOfUsers)
    %original parameters
    B = 50*10^6;% Hz
    Pt = 1; %watt
    N0 = 10^(-17); %noise density watt/Hz (-210 dBm/Hz)
    % free space loss dB for 2 GHz
    f = 1*10^9; %Hz
    
    fileName = strcat('Article_6_6/data/ES_coefficients_', num2str(NumberOfUsers));
    fileName = strcat(fileName,'.txt');
    PowerMatrix = dlmread(fileName,' ');
    
    fileName = strcat('Article_6_6/data/ES_fairness_', num2str(NumberOfUsers));
    fileName = strcat(fileName,'.txt');
    FairnessVector = dlmread(fileName,' ');
    
    allDistances = dlmread('Article_6_6/data/mean_distances.txt',' ');
    % arrays that will be written to a file start
    powerArray = zeros(1, NumberOfUsers);
    capacityMatrix = zeros(length(PowerMatrix), NumberOfUsers);
    sumCapacityVector = zeros(length(PowerMatrix), 1);
    % arrays that will be written to a file end
    loss = zeros(1, NumberOfUsers);
    %cap_oma = zeros(1, NumberOfUsers);    
    for i = 1: 1: NumberOfUsers
        distance = allDistances(1,i);
        loss(i) = -20*log10(distance) - 20*log10(f) + 147.55; %free space path loss
    end
    loss = 10.^(loss./10);
    %snrs = 10*log10((loss.*Pt) ./ (N0*B));
    %NOMA
    for i = 1:1:length(PowerMatrix)
        fairnessConstraint = FairnessVector(i);
        powers = PowerMatrix(i,:);
        for u = 1:1:NumberOfUsers 
            interf_Power = 0; 
            for u_interf = (u-1):-1:1
                h = (randn(1,1000) + 1i*randn(1,1000) )/sqrt(2); %Rayleigh flat channel 
                interf_Power = interf_Power + mean(powers(u_interf)*((abs(h).^2).')*Pt*loss(u)); 
            end 
            h = (randn(1,1000) + 1i*randn(1,1000) )/sqrt(2); %Rayleigh flat channel 
            capacityMatrix(i,u) = mean(B*log2(1 + powers(u)*((abs(h).^2).')*Pt*loss(u) / (N0*B + interf_Power))); 
        end
        sumCapacityVector(i) = sum(capacityMatrix(i,:));
        fairness = sumCapacityVector(i)^2 / (NumberOfUsers*sum( capacityMatrix(i,:).^2));
        
        if (fairness < fairnessConstraint-0.1 && fairness > fairnessConstraint+0.1)
            capacityMatrix(i,:) = zeros(1,NumberOfUsers);
        end       
    end
    %% finding max sum capacity
    [value_of_maximum_sum_capacity, index_of_maximum_sum_capacity]  = max(sumCapacityVector);        
    powerArray(1, :) = PowerMatrix(index_of_maximum_sum_capacity,:);

    file_power = strcat('Article_6_6/results/Mean_results_new/ES_coefficients_', num2str(NumberOfUsers));
    file_power = strcat(file_power,'.txt');

    file_capacity = strcat('Article_6_6/results/Mean_results_new/ES_capacity_', num2str(NumberOfUsers));
    file_capacity = strcat(file_capacity,'.txt');

    writematrix(powerArray, file_power, 'Delimiter',' ');
    writematrix(round(value_of_maximum_sum_capacity/1000000, 0), file_capacity, 'Delimiter',' ');
end