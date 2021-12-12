%% This function calculates sum capacity 
%% with given power allocation coefficients and distances
%% for preset number of UEs in a file.
function [sum_capacity] = sumCapacity(distances, coefficients, NumberOfUsers, model)
    %original parameters
    B = 50*10^6;% Hz
    Pt = 1; %watt    
    N0 = 10^(-17); % noise density watt/Hz (-210 dBm/Hz)
    % free space loss dB for 2 GHz
    f = 1*10^9; %Hz
    %%coefficients = coefficients./sum(coefficients);
    capacity = zeros(1, NumberOfUsers);
    loss = zeros(1, NumberOfUsers);    
    for i = 1: 1: NumberOfUsers
        loss(i) = -20*log10(distances(i)) - 20*log10(f) + 147.55; %free space path loss
    end
    loss = 10.^(loss./10);
    %snrs = 10*log10((loss.*Pt) ./ (N0*B));

    %% finding NOMA sum capacity
    for  u = 1:1:NumberOfUsers
        interf_Power = 0;
        for u_interf = (u-1):-1:1
            h = (randn(1,1000) + 1i*randn(1,1000) )/sqrt(2); %Rayleigh flat channel 
            interf_Power = interf_Power + mean(coefficients(u_interf)*((abs(h).^2).')*Pt*loss(u)); 
        end 
        h = (randn(1,1000) + 1i*randn(1,1000) )/sqrt(2); %Rayleigh flat channel 
        capacity(1,u) = mean(B*log2(1 + coefficients(u)*((abs(h).^2).')*Pt*loss(u) / (N0*B + interf_Power)));
        %% write capacity into files    
        file_capacity = strcat(model, '_capacity_');
        file_capacity = strcat(file_capacity, num2str(NumberOfUsers));
        file_capacity = strcat(file_capacity, '_');
        file_capacity = strcat(file_capacity, num2str(u));   
        file_capacity = strcat(file_capacity,'.txt');
        file_capacity = strcat('Article_6_8/results/', file_capacity);
        writematrix(capacity(1,u)/1000000, file_capacity, 'Delimiter',' ');
    end
   
    sum_capacity = round(sum(capacity)/1000000,0);
    %fprintf('capacity NOMA %.2f Mbps;\n', sum_capacity/1000000);
end    