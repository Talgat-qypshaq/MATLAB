P1 = 1;  P3 = 0.5;
P2 = 1;  P4 = 0.5;
h1 = 1;
h2 = 100;
count = 1;
countN = 1;
N=1;
R1 = 0:0.01:1; R3 = 0:0.01:1;
R2 = 0:0.01:1; R4 = 0:0.01:1;
for alpha = 0:0.01:1
    P1 = alpha;
    P2 = 1 - alpha; 
    R1(count) = log2(    1+  ((P1*h1)/(P2*h1 +N) )   );
    R2(count) = log2(1+(P2*h2/N));
    
    R3(count) = alpha*log2(1+((P3*h1)/(alpha*N)));
    R4(count) = (1-alpha)*log2(1+(P4*h2/((1-alpha)*N)));
    count = count + 1;
end
plot(R1, R2, 'B');
hold on
plot(R3, R4, 'G');
hold on
grid on; box on;
xlabel('Rate of user 1 (bps)') %Label for x-axis
ylabel('Rate of user 2 (bps)') %Label for y-axis
legend('NOMA', 'OMA');
set(gca,'FontSize', 16);
hold on 
