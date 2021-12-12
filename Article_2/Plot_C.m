%this file is for plotting data of article about SIC vs PIC
%in particular it plots data of CUDA computation times
clc;
clear;
PIC_4  = dlmread('data7/CUDA-4-QAM-PIC.txt','');
PIC_16 = dlmread('data7/CUDA-16-QAM-PIC.txt','');
SIC_4  = dlmread('data7/CUDA-4-QAM-SIC.txt','');
SIC_16 = dlmread('data7/CUDA-16-QAM-SIC.txt','');
UEs = dlmread('data7/UEs_CUDA.txt','');

%disp(PIC_4);
%disp(SIC_4);
%disp(PIC_16);
%disp(SIC_16);

timeArray = zeros(4, 8);

for i=1:1:8
    timeArray(1,i) = PIC_4(i);
    timeArray(2,i) = SIC_4(i);
    timeArray(3,i) = PIC_16(i);
    timeArray(4,i) = SIC_16(i);
end

figure(1)
p = plot(UEs, timeArray, 'LineWidth', 2 );
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = 'x';
p(4).Marker = '*';
xlim([0 2500]);
xlabel('Number of UEs')
ylabel('Time (ms)')
legend('PIC-QPSK', 'SIC-QPSK', 'PIC-16-QAM', 'SIC-16-QAM');