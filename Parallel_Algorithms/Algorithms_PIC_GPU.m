clc;
x = [50 100 150 200 250 300 350];

P_A_512  = [2.35 3.18 3.58 4.43 5.00 5.62 6.26];
P_A_1024 = [2.61 3.27 3.62 4.53 5.19 5.80 6.52];
P_A_2048 = [2.69 3.39 4.09 4.79 5.41 6.15 6.78];
P_A_4096 = [3.07 3.62 4.38 5.13 5.96 6.77 7.41];

figure(1)
hold on
plot(x, P_A_512, 'G', x, P_A_1024, 'R', x, P_A_2048, 'B' , x, P_A_4096, 'M');
grid on;
xlabel('number of UEs') %Label for x-axis
ylabel('time') %Label for y-axis
legend('512','1024', '2048', '4096')

q = 1:1:100;
y = log2(q);

figure(2)
hold on
plot(q, y, 'M');
grid on;
xlabel('number of UEs'); %Label for x-axis
ylabel('time'); %Label for y-axis
legend('512');
