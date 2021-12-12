function [ loss ] = channelGain( numberOfUsers )

%free space loss dB for 2 GHz
%m distance for the first user
d1 = 50; 
d_inc = 50; %m
f = 1*10^9; %Hz
loss = zeros(1, numberOfUsers);
%free space path loss
for i = 1:1:numberOfUsers
    loss(i) = -20*log10(d1 + d_inc*(i - 1)) - 20*log10(f) + 147.55;
    %fprintf('loss = %s ', num2str(loss(i), '%.3f'));
    %fprintf('\n');
end
loss = 10.^(loss./10);
 %for i = 1:1:numberOfUsers
 %    fprintf('loss = %s ', num2str(loss(i), '%.27f'));
 %    fprintf('\n');
 %end
end