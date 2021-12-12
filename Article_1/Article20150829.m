x1 = 1 + 1i;
x2 = 1 + 1i;

P1 = 1;
P2 = 1;
h1 = 1;
h2 = 100 ;
count = 1;
countN = 1;
N=1;
R1 = 0:0.01:1; 
R2 = 0:0.01:1; 
x=sqrt(P1)*x1+sqrt(P2)*x2;

for alpha = 0:0.01:1 
P1 = alpha;
P2 = 1-alpha;
R1(count)=log2(1+(P1*h1/N));
R2(count)=log2(1+((P2*h2)/(P1*h2+N)));
count = count + 1;
end

plot(R1, R2, 'B');
hold on
grid on; box on;
xlabel('Rate of user 1') %Label for x-axis
ylabel('Rate of user 2') %Label for y-axis
legend('NOMA');
hold on