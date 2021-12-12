x = [50 100 150 200 250 300 350];

A1 = zeros(7, 1);
A2 = zeros(7, 1);
A3 = zeros(7, 1);
A4 = zeros(7, 1);

for a=1:1:7
    A2(a) = x(a)*log10(x(a));    
    A3(a) = x(a);
    
    A1(a) = log10(x(a));
    A4(a) = log10(x(a)).^2;
end

figure(1)
hold on
plot(x, A2, 'G', x, A3, 'R');
grid on;
xlabel('number of UEs') %Label for x-axis
ylabel('time') %Label for y-axis

figure(2)
plot(x, A1, 'G', x, A4, 'B');
grid on;
%box on;
xlabel('number of UEs') %Label for x-axis
ylabel('time') %Label for y-axis