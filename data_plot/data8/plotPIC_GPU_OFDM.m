clc;

PIC_ARRAY_GPU = dlmread('data8/SIC_GPU_OFDM.txt',' ');
ARRAY_UEs = dlmread('data8/UEs.txt',' ');

%disp(columnCPU);
%disp(columnGPU);

%disp(ARRAY_UE);
%disp(SIC_ARRAY_GPU);
%disp(SIC_ARRAY_CPU);
%disp(SICtimeArray);

a = plot(ARRAY_UEs, PIC_ARRAY_GPU, 'LineWidth', 2 );
%a(1).Marker = 'o';
a(1).Marker = 'x';
%legend('PIC GPU','SIC GPU')
legend('PIC GPU')
xlabel('UEs'), ylabel('Time (milliseconds)')
%title('Time taken for SIC implementation on GPU and CPU devices')