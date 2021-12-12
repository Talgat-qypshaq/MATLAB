%this file is for plotting data of article about SIC vs PIC
clc;
QPSK_SIC_4 = dlmread('data7/QAM-4-SIC.txt',' ');
QPSK_PIC_4 = dlmread('data7/QAM-4-PIC.txt',' ');
QPSK_SIC_16 = dlmread('data7/QAM-16-SIC.txt',' ');
QPSK_PIC_16 = dlmread('data7/QAM-16-PIC.txt',' ');

UEs = dlmread('data7/UEs.txt',' ');

%disp(QPSK_SIC);
%disp(QPSK_PIC);
%disp(UEs);

timeArray = zeros(4,6);

for i=1:1:6
    timeArray(1,i) = QPSK_SIC_4(i);
    timeArray(2,i) = QPSK_PIC_4(i);
    timeArray(3,i) = QPSK_SIC_16(i);
    timeArray(4,i) = QPSK_PIC_16(i);
end

figure(1)
p = plot(UEs, timeArray, 'LineWidth', 2 );
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = 'x';
p(4).Marker = '*';

xlim([0 2500])
xlabel('Number of UEs')
ylabel('Time (ms)')
legend('SIC-QPSK', 'PIC-QPSK', 'SIC-QAM-16', 'PIC-QAM-16');