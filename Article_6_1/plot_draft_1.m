clc;clear;
array_d1 = dlmread('Article_6/results_2.txt',' ');
array_d_inc = dlmread('Article_6/results_3.txt',' ');

c_UE(:,1) = array_d1(:,1);
c_UE(:,2) = array_d1(:,2);
%c_UE(:,3) = array_d1(:,3);

c_UE(:,3) = array_d_inc(:,1);
c_UE(:,4) = array_d_inc(:,2);
%c_UE(:,6) = array_d_inc(:,3);

d = array_d1(:,4);

p = plot(d, c_UE, 'LineWidth', 2 );
p(1).Marker = 'x';
p(2).Marker = 'o';
p(3).Marker = '*';
p(4).Marker = '+';

ylim([10 100])

legend('UE 1','UE 2','UE 1 (i)','UE 2 (i)')
xlabel('distance'), ylabel('Mbps')
title('capacity dependent on distance')