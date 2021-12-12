FFT = [512 1024 2048 4096];
UE  = [50 100 150 200 250 300 350];

% PIC_GPU = [
%             2.35 3.18 3.58 4.43 5.00 5.62 6.26
%             2.61 3.27 3.62 4.53 5.19 5.80 6.52;
%             2.69 3.39 4.09 4.79 5.41 6.15 6.78;
%             3.07 3.62 4.38 5.13 5.96 6.77 7.22;           
%            ];
% SIC_GPU = [            
%             65.67 133.16 201.67 268.57 301.17 362.03 424.61            
%             68.53 136.19 205.33 274.39 322.36 374.2 435.91 
%             68.89 140.07 208.02 277.63 334.39 390.43 456.29
%             70.07 142.44 210.6 278.22 348.64 416.77 446.62            
%           ];            
% PIC_CPU = [            
%             19.17 35.68 50.72 68.4 85.41 105.88 117.47            
%             30.95 57.18 90.7 121.42 159.64 191.92 221.83           
%             54.27 118.40 169.50 236.91 299.46 335.37 416.39
%             110.74 227.48 336.85 439.99 548.99 664.06 750.53
%           ];
% SIC_CPU = [ 
%             16.93 33.12 46.45 57.22 76.53 93.31 107.86
%             28.24 57.36 81.17 109.96 139.41 165.09 190.72
%             51.69 99.17 155.9 197.16 259.84 312.22 365.59
%             101.67 197.59 305 403.14 506.17 595.15 718.87
%            ];
PIC_GPU = [
           3.07 3.62 4.38 5.13 5.96 6.77 7.22;           
          ];
SIC_GPU = [ 
           70.07 142.44 210.6 278.22 348.64 416.77 446.62            
          ];            
PIC_CPU = [
           110.74 227.48 336.85 439.99 548.99 664.06 750.53
          ];
SIC_CPU = [ 
           101.67 197.59 305 403.14 506.17 595.15 718.87
          ];
      
% SICtoPIConGPU = zeros(4, 7);
% SIConCPUtoPIConGPU = zeros(4, 7);
% PICtoPIC = zeros(4, 7);

SICtoPIConGPU = zeros(1, 7);
SIConCPUtoPIConGPU = zeros(1, 7);
PICtoPIC = zeros(1, 7);
ratio = zeros(3, 7);
for b = 1:1:7
    ratio(1,b) = PIC_CPU(b)/PIC_GPU(b);
    ratio(2,b) = SIC_CPU(b)/PIC_GPU(b);
    ratio(3,b) = SIC_GPU(b)/PIC_GPU(b);
end

% for a = 1:1:4
%     for b = 1:1:7
%     SICtoPIConGPU(a,b) = SIC_GPU(a,b)/PIC_GPU(a,b);
%     PICtoPIC(a,b) = PIC_CPU(a,b)/PIC_GPU(a,b);
%     SIConCPUtoPIConGPU(a,b) = SIC_CPU(a,b)/PIC_GPU(a,b);
%     end
% end

       disp(ratio);
       %disp(PICtoPIC);
       %disp(SIConCPUtoPIConGPU);
       
x = [50 100 150 200 250 300 350];
%y = [512 1024 2048 4096];
y = [1 2 3];
%y = [4096 2048 1024 512];
[xx,yy] = meshgrid(x,y);

figure; hold on
%colormap([1 0 0;0 0 1])
%surf(xx, yy, SIC_CPU, 'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none');
surf(xx, yy, ratio, 'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none');
% surf(xx, yy, SICtoPIConGPU, 'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none');
% surf(xx, yy, PICtoPIC, 'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none');
% surf(xx, yy, SIConCPUtoPIConGPU, 'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none');
%surf(xx, yy, PIC_GPU, 'FaceColor','b', 'FaceAlpha',0.5, 'EdgeColor','none');
%surf(xx, yy, PIC_CPU, 'FaceColor','y', 'FaceAlpha',0.5, 'EdgeColor','none');
%view(17,22);
%surf(xx, yy, zz);
%surf(xx, yy, zz);
title = ("PIC GPU funciton on OFDM from 50 to 350 UEs");
xlabel('number of UEs');
ylabel('1 for SIC on GPU, 2 for PIC on CPU, 3 for SIC on CPU');
%zlabel('time (ms)');
zlabel('speed up');
axis tight
shading interp
%colorbar







