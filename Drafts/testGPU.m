    clear;clc;
    tic;
    NumberOfUsers = 5;
    B = 50*10^6;
    Pt = 1;
    N0 = 10^(-17);
    d1 = 50; %m distance for the first user
    d_inc = 50; %m
    f = 1*10^9; %Hz
    loss = zeros(1, NumberOfUsers,'gpuArray');
    PowerMatrixCPU = dlmread('data/power5.txt',' ');
    PowerMatrix = gpuArray(PowerMatrixCPU);
    cap = zeros(length(PowerMatrix), NumberOfUsers, 'gpuArray');
    cap_oma = zeros(1, NumberOfUsers, 'gpuArray');
    for i = 1: 1: NumberOfUsers
        loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55;
    end
    loss = 10.^(loss./10);
    snrs = 10*log10((loss.*Pt) ./ (N0*B));
    %%% OMA
    for i = 1:1:NumberOfUsers
        cap_oma(i) = (B/NumberOfUsers)*log2(1+(Pt*loss(i)/(N0*B)));
    end

CapacityOma = sum(cap_oma);
fprintf('sum capacity oma %.8f \n', CapacityOma);
Fairness_oma = CapacityOma.^2/(NumberOfUsers*sum(cap_oma.^2));
Fairness_constraint = 0.9;
fprintf('Fairness_constraint %.1f \n', Fairness_constraint);
%%%% NOMA
maxf = 0; %just to keep max. fairness

for i = 1:1:length(PowerMatrix)
      powers = PowerMatrix(i,:);
      for u = 1:1:NumberOfUsers
          interf_Power = 0;
          for u_interf = (u-1):-1:1
              interf_Power = interf_Power + powers(u_interf)*Pt*loss(u);
          end
          %cap(i,u) = B*log2(1 + powers(u)*Pt*loss(u) / (N0*B + interf_Power));
      end
%     powers = PowerMatrix(i,:);
%     for u = 1:1:NumberOfUsers
%         interf_Power = 0;
%         for u_interf = (u-1):-1:1
%             interf_Power = interf_Power + powers(u_interf)*Pt*loss(u);
%         end
%         cap(i,u) = B*log2(1 + powers(u)*Pt*loss(u) / (N0*B + interf_Power));
%     end
%     fairness = sum(cap(i,:))^2 / (NumberOfUsers*sum(cap(i,:).^2));
%     if(i == 1)
%         fairness2 = fairness;
%     end
%     if fairness < Fairness_constraint
%         cap(i,:) = zeros(1,NumberOfUsers);
%     end
%     if fairness > maxf
%         maxf = fairness;
%     end
end
    tGPU = toc;
    disp(['Total time on GPU:       ' num2str(tGPU)]);