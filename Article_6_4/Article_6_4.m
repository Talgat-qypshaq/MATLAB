clc;
NumberOfUsers = 2;% please enter number of user equipments
B = 50*10^6;% Hz 
Pt = 1; %watt
N0 = 10^(-17);    %noise density watt/Hz (-210 dBm/Hz)
PowerMatrix = dlmread('data/power2.txt',' ');
powerArray = zeros(length(PowerMatrix), NumberOfUsers);
%free space loss dB for 2 GHz
distanceMatrix = dlmread('data/distances_2.txt',' ');
%trainingData = zeros(length(distanceMatrix), 5);
%trainingData_2 = zeros(length(distanceMatrix), 3);
%distance = zeros(length(NumberOfUsers), 1);
fprintf('user distance data rate power coefficient\n');    
    d1 = mean(distanceMatrix(:,1));
    d_inc = mean(distanceMatrix(:,2));
    fprintf('d1 = %d; d2 = %d; \n', round(d1,0), round(d_inc,0));
    %d1 = 50; %m distance for the first user
    %d_inc = 500; %m
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
    %fprintf('sum capacity oma %.8f \n', CapacityOma);
    Fairness_oma = CapacityOma.^2/(NumberOfUsers*sum(cap_oma.^2));
    %fprintf('Fairness index oma %.8f \n', Fairness_oma);
    %Fairness_constraint = 0.9;
    %fprintf('Fairness_constraint %.1f \n', Fairness_constraint);
    %%%% NOMA
    maxf = 0; %just to keep max. fairness
    %fairnessConstraintArray = [0.3, 0.5, 0.7, 0.9];
    fairnessConstraintArray = 0.9;
    capacityNOMA = zeros(4, NumberOfUsers+1);
    for fc = 1:numel(fairnessConstraintArray)
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
            if fairness < fairnessConstraintArray(fc)
                cap(i,:) = zeros(1,NumberOfUsers);
            %end
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
    %% finding min sum capacity
    %min_sum = 432344742;
    %min_sum_index = 0;
    %for i = 1:1:length(PowerMatrix)            
    %    if(sum(cap(i,:)) < min_sum) && (sum(cap(i,:)>0))
    %        min_sum = sum(cap(i,:));
    %        min_sum_index = i;
    %    end      
    %end
    %filling the training data array part 1
    
    for a=1:1:NumberOfUsers
        %fprintf('d1 = %d; data rate = %.2f; power ratio = %.2f; \n', d1, round(cap(max_sum_index,a)/1000000,2), powerArray(max_sum_index,a))
        %fprintf(a+" "+distance(a)+" "+round(cap(max_sum_index,a)/1000000,2)+" "+powerArray(max_sum_index,a)+'\n');
        %fprintf('user %d distance: %d; data rate: %.3f; power coefficient: %.2f\n',a, distance(a), cap(max_sum_index,a),powerArray(max_sum_index,a)); 
    end
    
    %for a=1:1:NumberOfUsers
    %    fprintf(a+" "+distance(a)+" "+cap(max_sum_index,a)+" "+powerArray(max_sum_index,a)+'\n');
        %fprintf('user %d distance: %d; data rate: %.3f; power coefficient: %.2f\n',a, distance(a), cap(max_sum_index,a),powerArray(max_sum_index,a)); 
    %end
    %fprintf('maximum sum capacity %.3f \n', max_sum);
    %fprintf('maximum row index %d \n', max_sum_index);

    %fprintf('minimum row value %.3f \n', min_sum);
    %fprintf('minimum row index %d \n', min_sum_index);

    sum_noma = sum(cap(max_sum_index,:));
    %sum_oma = sum(cap_oma);

    %fprintf('capacity NOMA %.8f \n', sum_noma);
    %fprintf('capacity OMA %.8f \n', sum_oma);

    %disp(cap(max_sum_index,:));
    %disp(PowerMatrix(max_sum_index,:));
    %disp(PowerMatrix(min_sum_index,:));
        for u=1:NumberOfUsers+1
            if(u==1)
                capacityNOMA(fc, u) = sum_noma;        
            end
            if(u>1)
                capacityNOMA(fc, u) = cap(max_sum_index, u-1);
            end             
        end
    end
%writematrix(trainingData,'data/trainingData.txt','Delimiter',' ');
%writematrix(trainingData_2,'data/trainingData_2.txt','Delimiter',' ');
%figure 1
%figure(1)
%bar(cap(max_sum_index,:));
%set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
%title('NOMA capacity throughput');
%xlabel('User equipments with optimally allocated power')
%ylabel('Throughput (bps)')

%figure 2
%figure(2)
%bar(cap_oma);
%set(gca,'xticklabel', PowerMatrix(max_sum_index,:));
%title('OMA capacity throughput');
%xlabel('User equipments with optimally allocated power')
%ylabel('Throughput (bps)')

%figure 3
%figure(3)
%bar(cap(min_sum_index,:));
%set(gca,'xticklabel', PowerMatrix(min_sum_index,:));
%title('NOMA capacity throughput');
%xlabel('User equipments with non-optimally allocated power')
%ylabel('Throughput (bps)')

%figure(4)
%p = plot(fairnessConstraintArray, capacityNOMA, 'LineWidth', 2 );
%p(1).LineWidth = 3;
%p(2).Marker = 'x';
%p(3).Marker = 'o';
%p(4).Marker = '*';
%p(5).Marker = '.';
%p(6).Marker = '+';

%title('Capacity obtained with five UEs for different fairness indexes');
%xlabel('Fairness Index')
%ylabel('Throughput (bps)')
%legend('SUM CAPACITY','UE1','UE2','UE3','UE4','UE5');