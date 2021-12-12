clear;
close all;
clc;

Ri=0.007;
qsi=1500*60*1000;

r2=[Ri];
qsm=[qsi];

syms qs real
qs1 = double(solve(3*qs^2+34,qs)); %m2/s
d=[];


for e=1:1:3
    syms a b real
    eqn3 = a-34==0;
    eqn4 = b+34==0;

    c = a+3;
    d =[d c];

    [a, b] = solve(eqn3, eqn4, [a, b]);
end
