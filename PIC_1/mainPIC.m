function [] = mainPIC(numberOfUsers, modulation)
    clc;
    %channel gain, noise and power
    channel = zeros(1, numberOfUsers);
    noise = zeros(1, numberOfUsers);
    power = zeros(1, numberOfUsers);
    
    for a=1:1:numberOfUsers
        channel(1,a) = sqrt(0.5)*(randn+1i*randn);
        nvar = 0.5/(10^(a/10));
        noise(1, a) = sqrt(nvar)*randn + 1i*sqrt(nvar)*randn;
        power(1,a) = 1/numberOfUsers; 
    end

    %sent message and received signal
    message = zeros(1, numberOfUsers);    
    signal = zeros(1, numberOfUsers);

    for i=1:1:numberOfUsers
        message(1,i) = generateQAM();
        %fprintf('generated message %.4f + %.4fi \n', real(message(1,i)), imag(message(1,i)) );
        signal(1,i) = sqrt(power(1,i))*message(1,i)*channel(1,i)+noise(1,i);
        %fprintf('generated signal %.4f + %.4fi \n', real(signal(1,i)), imag(signal(1,i)) );
    end

    %fprintf('\n');

    y_sum = sum(signal);
    tic
        for j=1:1:numberOfUsers
            PIC(power, channel, y_sum, numberOfUsers, modulation);
        end
    elapsedTime = toc;
    
    fprintf('overall PIC time: %.9f seconds \n', elapsedTime);
    clear;
end