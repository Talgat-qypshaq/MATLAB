clc;clear;
array_d_inc = dlmread('Article_6/results_3.txt',' ');

disp(array_d_inc);

c_UE(:,1) = array_d_inc(:,1);
c_UE(:,2) = array_d_inc(:,2);
c_UE(:,3) = array_d_inc(:,3);
d = array_d_inc(:,5);

a = plot(d, c_UE, 'LineWidth', 2 );
a(1).Marker = 'o';
a(2).Marker = 'x';

legend('UE 1','UE 2','sum')
xlabel('UE 1 distance'), ylabel('Mbps')
title('capacity dependent on distance inc')