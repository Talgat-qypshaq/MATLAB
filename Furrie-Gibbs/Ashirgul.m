clear all, close all, clc

for NN=1:1:1
L=4800;
N=4800;
dx=L/(N-1);

o=(NN-1)*L;
y= (NN-1)*L+L/2;

x =(NN-1)*L:dx:L*NN;
f=zeros(size(x));
f(o+1:y)=1;
A0= sum(f.*ones(size(x)))*dx*2/L;
fFS=A0/2;
for k=1:5
    Ak=sum(f.*cos(2*pi*k*x/L))*dx*2/L;
    Bk=sum(f.*sin(2*pi*k*x/L))*dx*2/L;
    fFS=fFS+Ak*cos(2*pi*k*x/L)+Bk*sin(2*pi*k*x/L);
end
end
plot(x,f,'k','Linewidth',4),hold on
plot(x, fFS, 'c-','Linewidth',3)