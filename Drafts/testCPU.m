    clear;clc;
    tic;
    NumberOfUsers = 5;
    B = 50*10^6;
    Pt = 1;
    N0 = 10^(-17);
    d1 = 50; %m distance for the first user
    d_inc = 50; %m
    f = 1*10^9; %Hz
    loss = zeros(1, NumberOfUsers);
    PowerMatrix = dlmread('data/power5.txt',' ');
    cap = zeros(length(PowerMatrix), NumberOfUsers);
    
    
    for i = 1: 1: NumberOfUsers
        loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
    end
       
    loss = 10.^(loss./10);
    snrs = 10*log10((loss.*Pt) ./ (N0*B));
    for  u = 1:1:NumberOfUsers
        interf_Power = 0;
        for u_interf = (u-1):-1:1
            interf_Power = interf_Power + Pt*loss(u);
        end
        cap(u) = B*log2(1 + Pt*loss(u) / (N0*B + interf_Power));                     
    end
       tCPU = toc;
    disp(['Total time on CPU:       ' num2str(tCPU)]);