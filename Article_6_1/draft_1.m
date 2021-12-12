clc;
%% understanding the path loss
a = [10 100 1000];
b = (a./10);
c = 10.^(a./10);
d = [1 2 3];
e = 10.^d;
f = 10.^b;
fprintf("b = %d\n",b);
fprintf("e = %d\n",e);
fprintf("f = %d\n",f);
power(3,2)