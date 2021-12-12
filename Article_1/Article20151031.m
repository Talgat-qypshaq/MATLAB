%Same mathematical model applied for three users
P1 = 1;
P2 = 1;
P3 = 1;

h1 = 1;
h2 = 10;
h3 = 100;

N=1;

count = 1;
countN = 1;

R1 = 0:0.01:1;
R2 = 0:0.01:1;
R3 = 0:0.01:1;
RatesMatrix = zeros(99,3);
SummsMatrix = zeros(99,1);
for alpha = 0.01:0.01:0.99
    P1 = alpha;
    P2 = (1-P1)/2;
    P3 = 1-P1-P2;
    PowerMatrix = [ P1, P2, P3 ];
    %disp(PowerMatrix);
    
    R1(count) = log2(    1 +  P1*h1*h1/(N+ (P2+P3)*h1*h1 )   );
    R2(count) = log2(    1 +  P2*h2*h2/(N+ (P3*h2*h2)  )   );
    R3(count) = log2(    1 +  P3*h3*h3/ N  );
    RatesMatrix(count, 1) = R1(count);
    RatesMatrix(count, 2) = R2(count);
    RatesMatrix(count, 3) = R3(count);
    SummsMatrix(count, 1) = R1(count)+R2(count)+R3(count);
    %RatesMatrix = [ R1(count),R2(count), R3(count) ];    
    
    count = count + 1;
end
%clc;
%disp(RatesMatrix);
%disp(SummsMatrix);
[MaxSUM,IndexMaxSum] = max(SummsMatrix);
[MaxRate,IndexMaxRate] = max(RatesMatrix);
disp('max rate');
%disp([MaxSUM,IndexMaxSum]);
%disp([MaxRate,IndexMaxRate] );

[MinSumm,IndexMinSumm] = min(SummsMatrix);
[MinRate,IndexMinRates] = min(RatesMatrix);
disp('min rate');
%disp([MinSumm,IndexMinSumm]);
%disp([MinRate,IndexMinRates] );
%plot(R1, R2, 'B');
%hold on
%grid on; box on;
%xlabel('Rate of user 1') %Label for x-axis
%ylabel('Rate of user 2') %Label for y-axis
%legend('NOMA');
%hold on 
