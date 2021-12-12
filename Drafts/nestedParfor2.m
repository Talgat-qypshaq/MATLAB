function cap = nestedParfor2()
    tic;
    NumberOfUsers = 5;
    B = 50*10^6;
    Pt = 1;
    N0 = 10^(-17);
    d1 = 50; %m distance for the first user
    d_inc = 50; %m
    f = 1*10^9; %Hz
    lossCPU = zeros(1, NumberOfUsers);
    loss = gpuArray(lossCPU);
    PowerMatrixCPU = dlmread('data/power5.txt',' ');
    PowerMatrix = gpuArray(PowerMatrixCPU);    
    capCPU = zeros(length(PowerMatrix), NumberOfUsers);
    cap = gpuArray(capCPU); 

    parfor i = 1: 1: NumberOfUsers
        loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55; %free space path loss
    end
    loss = 10.^(loss./10);
    parfor  u = 1:1:NumberOfUsers
        interf_Power = 0;
        for u_interf = (u-1):-1:1
            interf_Power = interf_Power + Pt*loss(u);
        end
        cap(u) = B*log2(1 + Pt*loss(u) / (N0*B + interf_Power));                     
    end
        tGPU = toc;
    disp(['Total time on GPU:       ' num2str(tGPU)]);
end