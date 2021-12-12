clc;
ARRAY_UE = dlmread('data3/NVIDIA_UE.txt',' ');
ARRAY_FI = dlmread('data3/NVIDIA_FI.txt',' ');

OPA_ARRAY_DELL = dlmread('data3/CAPACITY_NVIDIA_DELL.txt',' ');
OPA_ARRAY_SONY = dlmread('data3/CAPACITY_NVIDIA_SONY.txt',' ');
OPA_ARRAY_iMAC = dlmread('data3/CAPACITY_MATLAB_iMAC.txt',' ');

%SIC_ARRAY_GPU = dlmread('data3/NVIDIA_HP_HP.txt',' ');
%SIC_ARRAY_CPU = dlmread('data3/MATLAB_iMAC_SIC.txt',' ');

ALLtimeArray = zeros(3,9);
GPUtimeArray = zeros(2,9);

for i=1:1:9
    ALLtimeArray(1,i) = OPA_ARRAY_DELL(i)/1000;
    ALLtimeArray(2,i) = OPA_ARRAY_SONY(i)/1000;
    ALLtimeArray(3,i) = OPA_ARRAY_iMAC(i);
    GPUtimeArray(1,i) = OPA_ARRAY_DELL(i)/1000;
    GPUtimeArray(2,i) = OPA_ARRAY_SONY(i)/1000;
end

%disp(ARRAY_UE);
%disp(ARRAY_FI);

%disp(OPA_ARRAY_DELL/1000);
%disp(OPA_ARRAY_SONY/1000);
%disp(OPA_ARRAY_iMAC);

%disp(SIC_ARRAY_GPU);
%disp(SIC_ARRAY_CPU);

%disp(ALLtimeArray);

%g = plot(ARRAY_UE, GPUtimeArray, 'LineWidth', 2 );
%legend('GPU DELL','GPU Sony')
%xlabel('UEs'), ylabel('Time (seconds)')
%title('Time taken for Capacity throughput calculations on GPU devices')

a = plot(ARRAY_UE, ALLtimeArray, 'LineWidth', 3 );
legend('GTX 970','425M','Serial Intel Core i7')
xlabel('UEs'), ylabel('Time (seconds)')
    a(1).Marker = '+';
    a(2).Marker = 'x';
    a(3).Marker = 'o';
    
%title('Time spent for Capacity throughput calculations on CPU and GPU devices')