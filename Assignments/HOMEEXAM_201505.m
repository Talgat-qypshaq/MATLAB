%OMA

P1 = 1;
P2 = 1;
h1square = 1;
h2square = 100;
B = 1;
N = 1;
count = 1;
countN = 1;
R1 = 0:0.01:0.99;
R2 = 0:0.01:0.99;

for alpha = 0:0.01:0.99
    snr1 = (1/alpha)*(P1*h1square/(B*N));
    snr2 = (1/1-alpha)*P2*h2square/(B*N);
    R1(count) =     alpha*B*log(1+snr1);
    R2(count) = (1-alpha)*B*log(1+snr2);
    count = count + 1;
end

% for ke = 0:0.01:0.99
%      RN1(countN) = log(1+(P1*h1square));
%      RN2(countN) = log(1+(P2*h2square));
%      countN = countN+1;
% end

plot(R1, R2, 'r');
hold on
% plot(RN1, RN2, 'g');
grid on; box on;
xlabel('Rate of user 1') %Label for x-axis
ylabel('Rate of user 2') %Label for y-axis
legend('OFDMA');
hold on