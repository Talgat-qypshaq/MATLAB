%OFDMA
P1 = 0.5;
P2 = 0.5;
h1 = 1;
h2 = 100 ;
count = 1;
countN = 1;
N=1;
R1 = 0:0.01:1;
R2 = 0:0.01:1;
for alpha = 0:0.01:1
    R1(count) = alpha*log2(1+((P1*h1)/(alpha*N)));
    R2(count) = (1-alpha)*log2(1+(P2*h2/((1-alpha)*N)));
    count = count + 1;
end
plot(R1, R2, 'G');
hold on
%plot(R3, R4, 'g');
grid on; box on;
xlabel('Rate of user 1') %Label for x-axis
ylabel('Rate of user 2') %Label for y-axis
legend('OFDMA');
hold on