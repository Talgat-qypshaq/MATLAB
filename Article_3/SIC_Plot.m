clc;
ARRAY_UE = dlmread('data_plot/data4/NVIDIA_UE_13.txt',' ');

SIC_ARRAY_GPU = dlmread('data_plot/data4/HP_SIC_NVIDIA.txt',' ');
SIC_ARRAY_CPU = dlmread('data_plot/data4/HP_SIC_MATLAB.txt',' ');

[rowCPU, columnCPU] = size(SIC_ARRAY_CPU);
[rowGPU, columnGPU] = size(SIC_ARRAY_GPU);
%disp(columnCPU);
%disp(columnGPU);

SICtimeArray = zeros(2,9);

for i=1:1:9
    SICtimeArray(1,i) = SIC_ARRAY_GPU(i);
    SICtimeArray(2,i) = SIC_ARRAY_CPU(i);
end

%disp(ARRAY_UE);
%disp(SIC_ARRAY_GPU);
%disp(SIC_ARRAY_CPU);
%disp(SICtimeArray);

a = plot(ARRAY_UE, SICtimeArray, 'LineWidth', 2 );
a(1).Marker = 'o';
a(2).Marker = 'x';
legend('SIC GPU HP','SIC CPU HP')
xlabel('UEs'), ylabel('Time (milliseconds)')
%title('Time taken for SIC implementation on GPU and CPU devices')